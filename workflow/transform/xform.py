#!/usr/bin/env python
"""Derivation harness: apply a candidate rename ruleset to a git tree and
compare the result, blob-for-blob, with a target tree. No worktree touched."""
import subprocess, sys, hashlib, re, os, collections, json

REPO = os.environ.get("XFORM_REPO", r"F:/test_cl/split/_tmp/ios-port/work")

def git(*args, binary=False):
    r = subprocess.run(["git","-C",REPO,*args], capture_output=True)
    if r.returncode: raise SystemExit(f"git {' '.join(args)}: {r.stderr.decode(errors='replace')[:400]}")
    return r.stdout if binary else r.stdout.decode('utf-8', 'replace')

def read_tree(rev):
    out = git("ls-tree","-r","-z",rev, binary=True)
    d = {}
    for rec in out.split(b"\0"):
        if not rec: continue
        meta, path = rec.split(b"\t", 1)
        mode, typ, sha = meta.split(b" ")
        d[path.decode('utf-8','surrogateescape')] = (mode.decode(), typ.decode(), sha.decode())
    return d

class BlobReader:
    """One persistent `git cat-file --batch`; strictly interleaved write/read so
    the stdin/stdout pipes can never deadlock."""
    def __init__(self):
        self.p = subprocess.Popen(["git","-C",REPO,"cat-file","--batch"],
                                  stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    def get(self, sha):
        self.p.stdin.write((sha+chr(10)).encode()); self.p.stdin.flush()
        hdr = self.p.stdout.readline().decode().strip()
        parts = hdr.split(" ")
        if len(parts) != 3:
            raise SystemExit("cat-file: "+hdr)
        size = int(parts[2])
        buf = bytearray()
        while len(buf) < size:
            chunk = self.p.stdout.read(size-len(buf))
            if not chunk: raise SystemExit("short read")
            buf += chunk
        self.p.stdout.read(1)
        return bytes(buf)
    def close(self):
        try: self.p.stdin.close()
        except Exception: pass
        self.p.wait()

def batch_blobs(shas):
    r = BlobReader()
    out = {s: r.get(s) for s in shas}
    r.close()
    return out

def blob_sha(data):
    h = hashlib.sha1()
    h.update(b"blob %d\0" % len(data))
    h.update(data)
    return h.hexdigest()

# ---------------------------------------------------------------- rules
import rules as R

def main():
    src_rev, dst_rev = sys.argv[1], sys.argv[2]
    src, dst = read_tree(src_rev), read_tree(dst_rev)
    print(f"src {src_rev}: {len(src)} entries | dst {dst_rev}: {len(dst)} entries", flush=True)

    shas = sorted({v[2] for v in src.values() if v[1]=="blob"})
    print(f"loading {len(shas)} blobs ...", flush=True)
    blobs = {}
    CH = 4000
    for i in range(0, len(shas), CH):
        blobs.update(batch_blobs(shas[i:i+CH]))
    print("loaded.", flush=True)

    produced = {}
    collisions = []
    for path,(mode,typ,sha) in src.items():
        if typ != "blob":
            continue
        np = R.path_rule(path)
        data = blobs[sha]
        nd = R.content_rule(np, path, data)
        ns = sha if nd is data else blob_sha(nd)
        if np in produced: collisions.append(np)
        produced[np] = (mode, ns, path, nd)

    dst_blobs = {p:(v[0],v[2]) for p,v in dst.items() if v[1]=="blob"}
    missing = sorted(set(dst_blobs) - set(produced))      # target has, we didn't make
    extra   = sorted(set(produced) - set(dst_blobs))      # we made, target doesn't have
    common  = sorted(set(produced) & set(dst_blobs))
    bad = [p for p in common if produced[p][1] != dst_blobs[p][1]]
    badmode = [p for p in common if produced[p][0] != dst_blobs[p][0]]

    print(f"\nRESULT  produced={len(produced)}  target={len(dst_blobs)}")
    print(f"  path-missing (in target, not produced): {len(missing)}")
    print(f"  path-extra   (produced, not in target): {len(extra)}")
    print(f"  content-mismatch: {len(bad)}   mode-mismatch: {len(badmode)}   collisions: {len(collisions)}")

    out = os.environ.get("XFORM_OUT", r"F:/test_cl/split/_tmp/ios-port/residual")
    os.makedirs(out, exist_ok=True)
    open(out+"/missing.txt","w",encoding='utf-8').write("\n".join(missing))
    open(out+"/extra.txt","w",encoding='utf-8').write("\n".join(extra))
    open(out+"/content_mismatch.txt","w",encoding='utf-8').write("\n".join(bad))
    open(out+"/mode_mismatch.txt","w",encoding='utf-8').write("\n".join(badmode))

    # sample residual content diffs
    tgt_need = sorted({dst_blobs[p][1] for p in bad[:400]})
    tb = batch_blobs(tgt_need) if tgt_need else {}
    subs = collections.Counter()
    with open(out+"/content_diff_sample.txt","w",encoding='utf-8') as fh:
        for p in bad[:400]:
            ours = produced[p][3]; theirs = tb[dst_blobs[p][1]]
            try:
                a = ours.decode('utf-8').splitlines(); b = theirs.decode('utf-8').splitlines()
            except UnicodeDecodeError:
                fh.write(f"### {p}  (binary differs)\n"); subs[('<binary>','')]+=1; continue
            if len(a)==len(b):
                for x,y in zip(a,b):
                    if x!=y:
                        ta=re.split(r'(\W)',x); tb2=re.split(r'(\W)',y)
                        if len(ta)==len(tb2):
                            for u,v in zip(ta,tb2):
                                if u!=v: subs[(u,v)]+=1
                        else:
                            subs[('<LINE>', (x.strip()[:70]+' ||| '+y.strip()[:70]))]+=1
            else:
                subs[('<LENGTH>', p)]+=1
            fh.write(f"### {p}\n")
            n=0
            for x,y in zip(a,b):
                if x!=y and n<6:
                    fh.write(f"  ours   : {x[:200]}\n  target : {y[:200]}\n"); n+=1
            fh.write("\n")
    print("\n--- residual substitutions (ours -> target), top 60 ---")
    for (a,b),n in subs.most_common(60):
        print(f"{n:7d}  {a!r} -> {b!r}")
    print(f"\nresidual written to {out}")

if __name__ == "__main__":
    main()
