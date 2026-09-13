# iOS device connection

Notes on connecting an iPhone over USB, and viewing the photos it exposes
(HEIC) from the terminal.

## Mounting / browsing the device

Reference: [ArchWiki - IOS](https://wiki.archlinux.org/title/IOS).

Packages: `usbmuxd` (USB multiplexer daemon pairing/talking to the device),
`ifuse` (FUSE mount via libimobiledevice), `gvfs-afc` (GVFS/Nautilus
integration, AFC protocol), `gvfs-gphoto2` (GVFS camera-import mode for
photos).

## Viewing HEIC photos in the terminal (kitty)

`kitten icat` only natively decodes PNG/JPG/GIF/BMP/TIFF/WEBP. For HEIC (and
anything else), it delegates to ImageMagick — so ImageMagick needs to be
installed with HEIC support (`libheif`).

```bash
sudo pacman -S imagemagick libheif
```

`libheif` is normally pulled in as an optional dependency of `imagemagick`,
but install it explicitly to be sure.

Check that the HEIC delegate is active:

```bash
magick identify -list format | grep -i heic
```

Look for a `HEIC` line with `r` (read) in the mode column.

Display the file:

```bash
kitten icat --engine magick photo.heic
```

`--engine magick` forces ImageMagick. Otherwise kitty first tries its
internal "builtin" engine, which doesn't handle HEIC and can fail silently
depending on the version.

If ImageMagick still lacks HEIC support after installing (happens on some
distros where `libheif` is present but not detected at build time), fall
back to converting before displaying:

```bash
magick photo.heic photo.jpg && kitten icat photo.jpg
```
