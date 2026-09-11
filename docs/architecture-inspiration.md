# Architecture inspiration

Notes from surveying other Hyprland/Quickshell dotfiles repos, for ideas on
how this repo's tooling and `home/.config/quickshell/` layout could evolve.
Not a spec — just what's worth stealing, tied to the Issues that track
actually doing it.

## [sud0-L/odyssey](https://github.com/sud0-L/odyssey)

The main inspiration for this project's quickshell direction. A full
desktop shell (control center, dashboard, notification "island", app
launcher with a command palette) plus its own installer.

- **`core/`** holds shared singletons (`Config.qml`, `SettingsStore.qml`,
  `ShellState.qml`, `Theme.qml`, `Animations.qml`) that the rest of the
  shell depends on — a clear separation between "shared state/theme" and
  "one feature's UI".
- **`panels/`** — one file per big feature surface (`ControlCenter.qml`,
  `Dashboard.qml`, `NotificationCenter.qml`, `SettingsPage.qml`, ...);
  **`launcher/providers/`** — pluggable data providers behind the launcher
  (apps, clipboard, keybinds, workspaces), each a `qmldir`-scoped module.
- **`manager/`** is a whole Python package (`cli.py`, `install.py`,
  `acquire.py`, `reconcile.py`, `versioning.py`, `dependencies.py`,
  `contracts.py`) — a structured installer/lifecycle tool, not a single
  script. Releases are versioned artifacts (`VERSION`, `dist/<version>/
  odyssey-release.json` + `.ody`).
- `config/` bundles example dotfiles for the *rest* of the desktop (hypr,
  kitty, starship, zsh, fastfetch) alongside the shell's own QML source —
  kept clearly separate from it.

**Takeaway** → Issue: "Reorganize `quickshell/` toward a
`core/`/`panels/`/`providers/` layout"; Issue: "Merge `bootstrap` into
`dotfiles` as a subcommand" (the `manager/` package is the concrete
precedent for treating that as a real structured tool, not one script).

## [caelestia-dots/shell](https://github.com/caelestia-dots/shell)

A more mature, multi-contributor Quickshell shell project (C++ + QML,
`.clang-format`/`.clang-tidy`, CMake build).

- `components/` split into `controls/` (buttons, sliders, switches, ...)
  and `containers/` (flickables, list views, windows) — generic UI atoms
  kept separate from feature code, one level under a flat `components/`.
- `.github/` has `ISSUE_TEMPLATE/` (crash, feature, generic issue) and CI
  workflows including `check-pr-title.yml` and `check-pr-approvals.yml` —
  i.e. Conventional-Commits-style PR titles and the "no self-approval"
  concern are both things this project already enforces mechanically.

**Takeaway** → worth cheap, lightweight versions once this repo has more
than one contributor or agent opening PRs: an issue/PR template, maybe a
PR-title lint. Not built now; not its own Issue yet either — small enough
to fold into whichever Issue ends up touching `.github/`.

## [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland)

A large community dotfiles repo (the "illogical-impulse" rice).

- Config lives under `dots/.config/...`, mirroring `$HOME` — same idea as
  this repo's `home/`.
- Hyprland config splits `hyprland/` (upstream defaults) from `custom/`
  (user overrides layered on top via `shellOverrides/`) — a base/override
  split for config that's meant to be forked and locally tweaked.
- `dots-extra/` holds optional, OS- or feature-specific bundles (a Fedora
  variant, per-language fontsets, an Emacs theme) kept out of the main tree.

**Takeaway** → not directly needed today (this repo isn't multi-host or
meant to be forked-and-overridden by others yet), but the base/override
split is worth remembering if this ever needs to support more than one
machine.

## Others looked at

[ultimateBroK/dotfiles](https://github.com/ultimateBroK/dotfiles) and
[bgibson72/yahr-quickshell](https://github.com/bgibson72/yahr-quickshell) —
both smaller, single-maintainer Quickshell rices closer to this repo's
current scale; no structural pattern beyond what's already covered above.
The [Caelestia project](https://github.com/topics/quickshell) generally —
same shell as `caelestia-dots/shell`, packaged/distributed more like an
end-user product (themes, install docs) than a personal config.
