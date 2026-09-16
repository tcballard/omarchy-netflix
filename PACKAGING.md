# Pacman packaging preview

Status: development packaging, version `0.1.0pre1-1`. No official Omarchy inclusion or vendor endorsement. The existing user-local installer remains available.

## Build and install on x86_64 Arch / Omarchy

Requires `base-devel`, `git`, and Chromium. The package depends on Arch's `chromium` package; it does not install a browser from an arbitrary source. On the target Omarchy machine, Chromium 151 reported Widevine 4.10.3050.0 and protected Prime playback succeeded in a normal tab. The launchers therefore use the verified normal-window path rather than Chromium app mode.

From this checkout, as your ordinary user:

```bash
cd packaging
makepkg -f
sudo pacman -U ./omarchy-netflix-0.1.0pre1-1-x86_64.pkg.tar.zst
omarchy-netflix-migrate-local
```

The migration command runs without sudo, after the package is installed. It backs up the previous local desktop entry, matching helper and matching icon under `$XDG_DATA_HOME/omarchy-app-migration/` (default `~/.local/share/omarchy-app-migration/`). It refuses modified helpers/icons and symlinked files. It can be rerun. It never moves or removes the browser profile. If a local file has been customised, review it manually. The package itself has no installation or removal hooks that edit home directories.

Both launch methods use the existing `$XDG_CONFIG_HOME/omarchy-netflix/chrome` profile. The legacy directory name preserves existing login state. Close the app before upgrading. To update, install a newer package with `pacman -U`; automatic updates require a configured repository publishing this package. To remove:

```bash
sudo pacman -R omarchy-netflix
```

Removal preserves login data and migration backups. To return to the local installation, remove the package and rerun `bash install.sh` from the repository root. Avoid running the local installer while the package is installed, because its desktop entry overrides the system entry.

## Sources and release route

The recipe pins the Chromium normal-window launcher source to commit `841706bce22b84a6c39568cb8ba77252b9600b61` and a SHA-256 digest. Desktop and migration files are separately checksummed. It installs only `/usr/bin`, `/usr/share/applications`, icons and licence notices. Social preview artwork is excluded.

`packaging/.omarchy/package.json` is prepared as local-source metadata for a future `pkgbuilds/omarchy-netflix/` contribution. No upstream watch is declared yet: this is a commit-pinned development preview, not a tagged supported release. Before submission: perform Netflix playback and installed-launcher desktop acceptance, review icon redistribution, then tag a release and pin its archive/digest with a release watch.

Official packaging implementation inspected at `omacom/omarchy-pkgs@5fe236736607b1a9f6df3c3a4b364515f70eed53`. Its package tree contains no existing Netflix/Prime recipes. ARM is not declared supported by this preview.

## Validation

The `Package validation` GitHub workflow uses a disposable Arch container. It builds without runtime dependency checking, installs with an explicit assumed Chromium dependency, and supplies a fake Chromium executable. It tests package ownership, desktop validation, normal-window arguments, migration backup/refusal/idempotence, retained profiles, actual package upgrade and removal. This proves package mechanics only; it does not prove Netflix streaming.

Artifacts contain unsigned preview packages, SHA-256 digests, the package file list, generated `.SRCINFO` and namcap output. They are not production releases.

Target evidence: Omarchy, Chromium 151.0.7922.173 and Widevine 4.10.3050.0. Prime protected playback passed in normal-window mode, establishing the browser/DRM path but not Netflix compatibility. Netflix login, playback, window grouping, audio and fullscreen remain to be checked. See CI for package mechanics on each exact commit.

### Reproduced package lifecycle evidence

On 2026-09-15, Arch CI successfully built, installed, migrated, upgraded from revision 1 to 2, and removed the actual package, preserving login and unrelated-app markers. The fake browser verified the fixed URL and existing profile path. Modified helpers were refused and repeated migration was harmless. ShellCheck and desktop-file-validate passed. The current revision additionally asserts normal-window mode and rejects app mode.

The first lifecycle run reported an obsolete custom licence identifier from namcap; the recipe now uses `LicenseRef-Proprietary-Artwork` and CI fails on namcap errors. Expected warnings remain for restricting architecture-independent scripts to x86_64 and for runtime shell dependencies that static analysis cannot reliably identify. Final evidence is tied to the exact commit shown by the PR's checks.
