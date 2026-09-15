# Netflix for Omarchy — unofficial launcher

<img src="https://raw.githubusercontent.com/tcballard/omarchy-badges/75975e5b5bf75e7ede3764bcd2950046f7abfe2c/badges/v1/omarchy-app.svg" height="20" alt="Omarchy app">

Open Netflix in its own Google Chrome app window, like Omarchy's bundled X web app. No tabs or address bar, with a persistent Netflix-only Chrome profile. This is an independent launcher, not affiliated with or endorsed by Netflix. The badge identifies a community app, not official approval.

Development preview 0.1.0. Intended for Omarchy 4 on x86_64. No installed Omarchy version has been tested here. Google Chrome and a Netflix account are required. The launcher uses Netflix's official 64×64 website PNG icon, unchanged. It does not modify Netflix's interface.

## Pacman packaging preview

See [PACKAGING.md](PACKAGING.md) for the package build, migration, upgrade/removal instructions and current browser dependency limitation. This is not yet an Omarchy repository package.

## Install locally

Clone the repository and install:

```bash
git clone https://github.com/tcballard/omarchy-netflix.git
cd omarchy-netflix
bash install.sh
```

Search for **Netflix** in the app launcher. Install Google Chrome through Omarchy if prompted. Sign in directly on Netflix's website. Installation needs no sudo, downloads nothing, and changes no browser defaults, keybindings or Hyprland settings.

To launch directly from the extracted folder:

```bash
bash omarchy-netflix
```

## Data, updates and removal

Chrome stores this app's cookies, login and settings in `$XDG_CONFIG_HOME/omarchy-netflix/chrome`, or `~/.config/omarchy-netflix/chrome` when unset or relative. This profile is separate from your everyday browser. It is not an additional OS sandbox. Chrome's normal sandbox remains enabled.

The installer writes only its helper under `$XDG_DATA_HOME/omarchy-netflix`, its desktop entry under `$XDG_DATA_HOME/applications`, and its icon under `$XDG_DATA_HOME/icons/hicolor/64x64/apps`. Unset or relative XDG_DATA_HOME falls back to `~/.local/share`. Re-running the installer updates those launcher files and preserves the profile. Re-run an older extracted installer to roll back the launcher.

Remove using the extracted folder:

```bash
bash uninstall.sh
```

Removal preserves all login data. To erase it, close Netflix and delete only the `omarchy-netflix` profile folder described above using your file manager. Chrome itself is managed and updated separately through your package manager.

## Playback and limitations

The launcher selects `google-chrome-stable` or `google-chrome`, uses Chrome app mode and delegates startup to `uwsm-app` when available in a Wayland session. It does not accept arbitrary URLs or browser flags. Existing browser sandbox and GPU settings remain enabled.

Netflix's [browser requirements](https://help.netflix.com/en/node/30081) list Linux playback up to 1080p but do not guarantee Linux compatibility. This package promises neither 4K nor offline downloads. It does not bundle or patch Widevine, scrape Netflix, or replace its player.

Live acceptance remains required: login, protected video playback, audio, subtitles, fullscreen, sleep inhibition, scaling, app icon/window grouping and reopening after sign-in on the XPS. No playback screenshot or successful playback claim is included.

## Reference and licence

Pattern inspected: Omarchy's [X.desktop](https://github.com/omacom/omarchy/blob/2fbac0c8e88eca704af1650ce721a494bd11a3d0/applications/X.desktop) and web-app helpers at revision `2fbac0c8e88eca704af1650ce721a494bd11a3d0` on 2026-09-15. Launcher and installer code are original; MIT licensed. The bundled `netflix.png` was downloaded on 2026-09-15 from https://assets.nflxext.com/us/ffe/siteui/common/icons/nficon2016.png, the apple-touch-icon linked by https://www.netflix.com/. Netflix owns this artwork; it is excluded from the launcher code's MIT licence. Inclusion does not imply endorsement or an unrestricted licence to the Netflix mark. Netflix and Google Chrome remain their owners' products.

The installer registers the app as **Netflix** using a user-local `.desktop` entry. This is desktop launcher registration, not a pacman package. Existing installations get the updated name by updating the checkout and rerunning `bash install.sh`.
