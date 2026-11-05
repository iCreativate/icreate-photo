# Pulling updates from PhotoCraft

iCreate Photo is a fork of [storytold/photocraft](https://github.com/storytold/photocraft).
Keep editing features in sync by merging upstream regularly; re-apply only the small branding
surface (name, icon, splash, About, bundle id, release workflow, `UPDATE_APP` / links).

## One-time setup

```sh
cd /path/to/icreate-photo
git remote add upstream https://github.com/storytold/photocraft.git
git fetch upstream
```

Confirm:

```sh
git remote -v
# origin    https://github.com/iCreativate/icreate-photo.git
# upstream  https://github.com/storytold/photocraft.git
```

## Regular sync

```sh
git checkout main
git fetch upstream
git merge upstream/main
# or: git rebase upstream/main
```

Resolve conflicts carefully:

1. **Keep our branding** in: `NOTICE`, `docs/brand/`, `assets/app-icon/` (iCreate mark),
   `crates/ui-egui` splash / About / title / `UPDATE_APP` / `APP_ID` / `APP_NAME` / links,
   `packaging/**` display names and `za.co.icreativate.icreate-photo`,
   `.github/workflows/release.yml` (tag-triggered, like the launcher), `docs/releasing.md`,
   `docs/upstream.md`.
2. **Take upstream** for editing, engine, codecs, UI tools, tests, and anything not in that list.
3. If upstream renames icon paths or `APP_ID`, re-point our include paths and packaging files to
   `za.co.icreativate.icreate-photo` and regenerate icons with `packaging/icons.sh`.
4. If upstream bumps `CRAFT_FONTS_REF` in their CI, copy the same pin into our `release.yml` and
   `ci.yml`.

Then:

```sh
git push origin main
```

Optional: tag a release after a sync if you want users on the new PhotoCraft bits
(`cargo xtask version set …`, commit, `git tag v…`, push with tags).

## Do not

- Do not force-push `main` after rewriting history that others may have pulled.
- Do not drop `LICENSE-MIT`, `LICENSE-APACHE`, `NOTICE`, or `ATTRIBUTION.md`.
- Do not reintroduce ArtCraft Marks into the UI; credit PhotoCraft / ArtCraft Team in plain text only.
