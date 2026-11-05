# iCreate Photo app icon

The **iCreate leaping figure** mark (cyan on transparent), shared with the iCreate launcher.

## Palette

| Colour | Hex | Used for |
|---|---|---|
| Figure | `#00c2d4` | the leaping figure |
| Field | transparent | outside the mark |

## Files

- `docs/brand/icreate-mark.svg`: canonical master (also copied here as `photocraft.svg` /
  `icreate-photo.svg` for packaging paths that still expect those names).
- `photocraft-1024.png`: 1024 px render on the macOS grid.
- `photocraft.icns`: macOS bundle icon (`CFBundleIconFile`).
- `photocraft.ico`: Windows icon, 16–256 px, embedded in the `.exe` by `apps/photocraft/build.rs`.
- `hicolor/<size>/apps/za.co.icreativate.icreate-photo.png` (16–512) and
  `hicolor/scalable/...svg`: Linux icon theme.

Asset **stems** for GitHub release installers stay `photocraft-<ver>-…` so the iCreate launcher
can install this fork. The display name and bundle id are iCreate Photo /
`za.co.icreativate.icreate-photo`.

Regenerate with `packaging/icons.sh` (needs `resvg`). Trademark terms: `docs/brand/LICENSE-brand.txt`.
