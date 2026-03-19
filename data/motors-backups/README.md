# MOTORS Backups (Dec 1994)

Zoo-format backups of the MOTORS CSP solver. Moved from `csp/Bak/`.

## Files

| File | Size |
|------|-----:|
| motor-dec11-3.zoo | 90 KB |
| motors-dec11-2.zoo | 89 KB |
| motors-dec11.zoo | 88 KB |

All three are from December 11, 1994 and likely represent incremental
snapshots of the solver taken the same day.

## Format

**.zoo** is an obsolete compression format from the early 1990s, commonly
used on Amiga and early UNIX systems. It is no longer widely supported.

## Decompression

```bash
# macOS (via Homebrew)
brew install zoo
zoo x motors-dec11.zoo

# Linux (Debian/Ubuntu)
sudo apt-get install zoo
zoo x motors-dec11.zoo
```

## Contents

Believed to contain source code snapshots of the MOTORS solver from late
1994, between v1.01 (Sep 1993) and the May 1996 codebase. These have not
been verified -- the .zoo format tools may need to be installed to inspect
their contents.
