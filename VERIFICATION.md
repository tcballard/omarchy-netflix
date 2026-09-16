# Verification — 2026-09-15

Inputs: `SHA256SUMS` identifies the tested implementation and accompanying documentation. Upstream inspected at `2fbac0c8e88eca704af1650ce721a494bd11a3d0`.

Historical checks on the original implementation (before the icon update), exit 0:
- `bash -n omarchy-netflix install.sh uninstall.sh`.
- Temporary-directory subprocess smoke harness invoked the actual installer, decoded the generated desktop Exec through both escaping layers, and executed the installed helper against a fake browser executable.
- Confirmed fixed Netflix URL, persistent profile argument, private new profile directory, paths containing spaces/percent/dollar/backtick/quote/backslash, repeat installation and removal preserving profile data, rejection of extra browser options, missing-Chrome error, relative XDG fallback, and Wayland uwsm delegation using a stub.

The temporary harness did not open Chrome or use real account data.

Current target-machine evidence on 2026-09-16: Omarchy, Chromium 151.0.7922.173 and Widevine 4.10.3050.0; protected Prime playback passed in normal-window mode and failed with error 7031 in app mode. Package validation also checks the reported `0.1.0` launcher version. This establishes the chosen browser/DRM path, but Netflix login/playback, window grouping, fullscreen, audio, scaling and sleep inhibition remain unverified.

Environment: Linux-6.18.44-x86_64-with-glibc2.39
GNU bash, version 5.2.21(1)-release (x86_64-pc-linux-gnu)

## Official icon update
Reproduced now, exit 0: bash syntax check; install into a temporary path with spaces; installed PNG byte-for-byte match; desktop icon name match; uninstall removes the icon. PNG is 64×64 RGBA, downloaded unchanged from Netflix’s website asset server. No live desktop validation. Current inputs: SHA256SUMS.

Original input hashes for historical checks:
```
96a2caaeba68af6cc022ff15a7f6ac52e6d9ac149a0d909d1d349b5835f6bae8  omarchy-netflix
8755f4531949c861c0f16517b4023b4f529030cf871e64abad43ea4f7728f7c5  install.sh
f6e4e936808875c9a5b0427c63ab381ed4d0b5b6a5d50f8f656869235734f29f  uninstall.sh
7c7cfd4eedbc339d51c862eece0083ee2fa05b8b51831b8bb2873a6ed9bca368  README.md
277db3cbc16e79e9586c768e650c403096ef3b25c355d53a3c7ff13eea1fc2c0  LICENSE
```

## Pacman packaging development

The earlier local-installer results above are historical. New package validation and its explicit limits are documented in [PACKAGING.md](PACKAGING.md) and the per-commit GitHub workflow.
