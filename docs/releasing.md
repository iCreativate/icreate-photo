# Releasing iCreate Photo

Tag a version. GitHub Actions builds the installers, writes `SHA256SUMS.txt`, and publishes a
GitHub Release. The iCreate launcher installs from `iCreativate/icreate-photo` using the
**`photocraft-<ver>-…`** asset stem (unchanged from upstream PhotoCraft).

```sh
# Version lives only in [workspace.package] version (Cargo.toml).
cargo xtask version set 0.20.1
git add Cargo.toml Cargo.lock crates apps xtask
git commit -m "Release 0.20.1"
git tag v0.20.1
git push origin main --tags
```

The tag must match Cargo.toml (`v0.20.1` ↔ `0.20.1`). A mismatch fails the workflow.

Until Apple and Windows certificates are in GitHub secrets, the same workflow still publishes
**unsigned** builds. The release notes tell people how to open them.

## What a tag builds

| Platform | File | Notes |
|---|---|---|
| macOS 11+ | `photocraft-<ver>-macos-universal.dmg` | `iCreate Photo.app`, Intel and Apple silicon (`lipo`) |
| Windows 10/11 | `photocraft-<ver>-windows-x64.msi` (+ portable zip) | Display name iCreate Photo |
| Linux x86_64 and aarch64 | `photocraft-<ver>-linux-<arch>.AppImage` and `.deb` | Bundle id `za.co.icreativate.icreate-photo` |

Desktop builds check out [craft-fonts](https://github.com/storytold/craft-fonts) at the pin in
`.github/workflows/release.yml` (`CRAFT_FONTS_REF`) and set `CRAFT_FONTS_DIR` /
`CRAFT_FONTS_REQUIRED=1`.

A version with a hyphen (`0.20.1-rc.1`) is marked prerelease.

## Certificates

Same secrets and process as [icreate-launcher `docs/releasing.md`](https://github.com/iCreativate/icreate-launcher/blob/main/docs/releasing.md):
`APPLE_CERTIFICATE`, `APPLE_CERTIFICATE_PASSWORD`, `KEYCHAIN_PASSWORD`, `APPLE_ID`,
`APPLE_PASSWORD`, `APPLE_TEAM_ID`, and optionally Windows Authenticode / Azure signing.
You do **not** need them for the first unsigned release.

When you have an Apple Team ID, put it in the launcher `apps.json` photo entry as `"mac_team"`
so the launcher will install signed DMGs.

## Upstream PhotoCraft

See [docs/upstream.md](upstream.md) for regularly merging `storytold/photocraft`.
