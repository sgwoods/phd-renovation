# MOTORS Releases (1993)

Compressed archives of the MOTORS CSP solver releases. Moved from
`csp/Releases/`.

## Files

| File | Version | Date | Size |
|------|---------|------|-----:|
| MOTORS.v0.5.tar.Z | 0.5 | Jul 1993 | 78 KB |
| MOTORS.v0.6.tar.Z | 0.6 | Jul 1993 | 80 KB |
| MOTORS.v0.7.tar.Z | 0.7 | Sep 1993 | 81 KB |
| MOTORS.v1.0.tar.Z | 1.0 | Aug 1993 | 130 KB |
| MOTORS.v1.01.tar.Z | 1.01 | Sep 1993 | 231 KB |

## Format

**.tar.Z** -- Unix tar archive compressed with `compress` (LZW). This is a
standard UNIX format from the early 1990s, predating gzip.

## Decompression

```bash
uncompress MOTORS.v0.5.tar.Z   # produces MOTORS.v0.5.tar
tar xf MOTORS.v0.5.tar         # extracts contents
```

Or in one step: `zcat MOTORS.v0.5.tar.Z | tar xf -`

Both `uncompress` and `zcat` are available by default on macOS and Linux.

## Contents

These archives contain the MOTORS (Method Of Terrain Recognition and
Observation Through Satisfaction) CSP solver source code at various stages
of development. The final version in the repository is effectively v1.2
(see `data/csp-misc/README` for version history).
