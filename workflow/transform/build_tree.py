#!/usr/bin/env python
"""Apply the ruleset to a git tree and WRITE the result as a real git tree+commit.
Unchanged blobs reuse their existing sha; only transformed ones are hashed."""
import subprocess, sys, os, tempfile, shutil
REPO = os.environ.get("XFORM_REPO", r"F:/test_cl/split/_tmp/ios-port/work")
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import rules as R
from xform import read_tree, BlobReader

def main():
    src_rev  = sys.argv[1]
    out_ref  = sys.argv[2]
    message  = sys.argv[3]
    parent   = sys.argv[4] if len(sys.argv) > 4 else None

    src = read_tree(src_rev)
    print(f"src {src_rev}: {len(src)} entries", flush=True)
    br = BlobReader()

    tmp = tempfile.mkdtemp(prefix="xf_", dir=r"F:/test_cl/split/_tmp/ios-port")
    entries = []          # (mode, sha_or_None, path, tmpfile)
    changed = []
    n = 0
    for path, (mode, typ, sha) in sorted(src.items()):
        if typ != "blob":
            entries.append((mode, sha, R.path_rule(path), None))
            continue
        data = br.get(sha)
        nd = R.content_rule(R.path_rule(path), path, data)
        np = R.path_rule(path)
        if nd is data or nd == data:
            entries.append((mode, sha, np, None))
        else:
            f = os.path.join(tmp, "b%06d" % n); n += 1
            open(f, "wb").write(nd)
            entries.append((mode, None, np, f))
            changed.append(f)
    br.close()
    print(f"transformed blobs: {len(changed)}", flush=True)

    shas = {}
    if changed:
        p = subprocess.run(["git","-C",REPO,"hash-object","-w","--stdin-paths"],
                           input="\n".join(changed).encode(), capture_output=True)
        if p.returncode: raise SystemExit(p.stderr.decode()[:500])
        out = p.stdout.decode().split()
        assert len(out) == len(changed), (len(out), len(changed))
        shas = dict(zip(changed, out))

    idx = os.path.join(tmp, "index")
    env = dict(os.environ, GIT_INDEX_FILE=idx)
    lines = []
    for mode, sha, path, f in entries:
        s = sha if sha else shas[f]
        lines.append(f"{mode} {s}\t{path}")
    p = subprocess.run(["git","-C",REPO,"-c","core.longpaths=true","update-index","--index-info"],
                       input="\n".join(lines).encode(), capture_output=True, env=env)
    if p.returncode: raise SystemExit(p.stderr.decode()[:800])
    tree = subprocess.run(["git","-C",REPO,"write-tree"], capture_output=True, env=env).stdout.decode().strip()
    print("tree:", tree, flush=True)

    args = ["git","-C",REPO,"commit-tree",tree,"-m",message]
    if parent: args += ["-p", parent]
    env2 = dict(os.environ,
                GIT_AUTHOR_NAME="Ony/3z", GIT_AUTHOR_EMAIL="fadum1ka@pm.me",
                GIT_COMMITTER_NAME="Ony/3z", GIT_COMMITTER_EMAIL="fadum1ka@pm.me",
                GIT_AUTHOR_DATE="2026-09-21T12:00:00 +0300",
                GIT_COMMITTER_DATE="2026-09-21T12:00:00 +0300")
    commit = subprocess.run(args, capture_output=True, env=env2).stdout.decode().strip()
    subprocess.run(["git","-C",REPO,"update-ref",out_ref,commit], check=True)
    print("commit:", commit, "->", out_ref, flush=True)
    shutil.rmtree(tmp, ignore_errors=True)

if __name__ == "__main__":
    main()
