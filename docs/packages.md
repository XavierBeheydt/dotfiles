# Package sources: native vs Flatpak

Rule of thumb for where an application is installed from. `pkg.list` only
tracks native packages (`pacman`/AUR); Flatpak apps are not listed there.

## Native (pacman / AUR)

- **Steam** (`steam`) — the Flatpak build had rendering issues on Hyprland.
- **OBS Studio** (`obs-studio`) plus its plugins, notably `obs-vkcapture`
  (AUR) and `lib32-obs-vkcapture` (AUR, for 32-bit games).

Game capture with `obs-vkcapture` hooks into the game's Vulkan/OpenGL
process, so OBS and the game must live in the same (non-sandboxed)
environment. Under Flatpak the capture socket is not shared across the
sandbox boundary, which is why OBS and Steam are both native.

### Capturing a Steam game

Set the game's launch options in Steam (Properties → Launch Options):

```
obs-gamecapture %command%
```

Then add a "Game Capture" source (provided by `obs-vkcapture`) in OBS.

## Flatpak

Creative applications such as Blender, Kdenlive and GIMP stay in Flatpak.

NOTE: `blender`, `gimp` and `kdenlive` still appear in `pkg.list` as native
packages; drop them from there once the Flatpak versions fully replace them.
