# Netflix for Omarchy — unofficial launcher

<img src="https://raw.githubusercontent.com/tcballard/omarchy-badges/75975e5b5bf75e7ede3764bcd2950046f7abfe2c/badges/v1/omarchy-app.svg" height="20" alt="Omarchy app">

Open Netflix in its own Chromium window with a persistent Netflix-only profile. This is an independent launcher, not affiliated with or endorsed by Netflix. The badge identifies a community app, not official approval.

Current release: **v0.1.0**. Intended for Omarchy 4 on x86_64. Chromium and a Netflix account are required. The launcher uses Netflix's official 64×64 website PNG icon, unchanged. It does not modify Netflix's interface. Normal Chromium window mode is used because that is the protected-playback path verified on the target Omarchy machine.

## Arch package

See [PACKAGING.md](PACKAGING.md) for package installation, migration, upgrade and removal instructions. This is an official release of this community project, not an Omarchy repository package or a Netflix product.

## Install locally

Clone the repository and install:

```bash
git clone https://github.com/tcballard/omarchy-netflix.git
cd omarchy-netflix
bash install.sh
```

Search for **Netflix** in the app launcher. Install Chromium through Omarchy if prompted. Sign in directly on Netflix's website. Installation needs no sudo, downloads nothing, and changes no browser defaults, keybindings or Hyprland settings.

To launch directly from the extracted folder:

```bash
bash omarchy-netflix
```

## Data, updates and removal

Chromium stores this app's cookies, login and settings in `$XDG_CONFIG_HOME/omarchy-netflix/chrome`, or `~/.config/omarchy-netflix/chrome` when unset or relative. The legacy `chrome` directory name is retained so upgrades preserve existing logins. This profile is separate from your everyday browser. It is not an additional OS sandbox. Chromium's normal sandbox remains enabled.

The installer writes only its helper under `$XDG_DATA_HOME/omarchy-netflix`, its desktop entry under `$XDG_DATA_HOME/applications`, and its icon under `$XDG_DATA_HOME/icons/hicolor/64x64/apps`. Unset or relative XDG_DATA_HOME falls back to `~/.local/share`. Re-running the installer updates those launcher files and preserves the profile. Re-run an older extracted installer to roll back the launcher.

Remove using the extracted folder:

```bash
bash uninstall.sh
```

Removal preserves all login data. To erase it, close Netflix and delete only the `omarchy-netflix` profile folder described above using your file manager. Chromium itself is managed and updated separately through your package manager.

## Playback and limitations

The launcher selects `chromium`, uses a normal dedicated window and delegates startup to `uwsm-app` when available in a Wayland session. It does not accept arbitrary URLs or browser flags. Existing browser sandbox and GPU settings remain enabled.

Netflix's [browser requirements](https://help.netflix.com/en/node/30081) list Linux playback up to 1080p but do not guarantee Linux compatibility. This package promises neither 4K nor offline downloads. It does not bundle or patch Widevine, scrape Netflix, or replace its player.

Live acceptance remains required for Netflix itself: login, protected video playback, audio, subtitles, fullscreen, sleep inhibition, scaling, app icon/window grouping and reopening after sign-in on the XPS. Prime protected playback passed in the same underlying normal Chromium mode; that does not prove Netflix playback.

## Reference and licence

Pattern inspected: Omarchy's [X.desktop](https://github.com/omacom/omarchy/blob/2fbac0c8e88eca704af1650ce721a494bd11a3d0/applications/X.desktop) and web-app helpers at revision `2fbac0c8e88eca704af1650ce721a494bd11a3d0` on 2026-09-15. Launcher and installer code are original; MIT licensed. The bundled `netflix.png` was downloaded on 2026-09-15 from https://assets.nflxext.com/us/ffe/siteui/common/icons/nficon2016.png, the apple-touch-icon linked by https://www.netflix.com/. Netflix owns this artwork; it is excluded from the launcher code's MIT licence. Inclusion does not imply endorsement or an unrestricted licence to the Netflix mark. Netflix and Chromium remain their owners' products.

The installer registers the app as **Netflix** using a user-local `.desktop` entry. This is desktop launcher registration, not a pacman package. Existing installations get the updated name by updating the checkout and rerunning `bash install.sh`.
