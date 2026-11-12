"""Export bounded compiler diagnostics without command lines or source excerpts."""
import json
from pathlib import Path
import re
import sys


def collect(root):
    diagnostics = set()
    total = 0
    pattern = re.compile(r'([^\s:]+\.(?:swift|h|m|mm|cpp|c)):(\d+):(\d+):\s*(?:fatal )?error:\s*([^\r\n]+)')
    for path in sorted(root.glob('*/execroot/_main/bazel-out/_tmp/actions/stderr-*')):
        if not path.is_file() or path.is_symlink():
            continue
        size = path.stat().st_size
        if size > 16 * 1024 * 1024 or total + size > 64 * 1024 * 1024:
            continue
        total += size
        text = path.read_text(encoding='utf8', errors='replace')
        text = re.sub(r'\x1b\[[0-9;]*m', '', text)
        for file, line, column, message in pattern.findall(text):
            message = re.sub(r'[a-f0-9]{32,}', '[redacted]', message, flags=re.I)
            message = re.sub(r'\d{4,}:[A-Za-z0-9_-]{20,}', '[redacted]', message)
            diagnostics.add((file, int(line), int(column), message[:600]))
    return {'bytesInspected': total, 'diagnosticCount': len(diagnostics),
            'diagnostics': [dict(file=f, line=l, column=c, message=m)
                            for f, l, c, m in sorted(diagnostics)[:1000]],
            'rawCompilerOutputIncluded': False}


if __name__ == '__main__':
    result = collect(Path(sys.argv[1]))
    destination = Path(sys.argv[2])
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(json.dumps(result, indent=2)+'\n', encoding='utf8')
    print('Captured', result['diagnosticCount'], 'compiler diagnostics; raw output excluded')
