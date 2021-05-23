purescript-gnome-shell
======================

GNOME Shell extension bindings for [PureScript][purescript].

Use this library to write GNOME Shell extensions with purescript.

Project using purescript-gnome-shell:

- [autochill][autochill], help you chill by setting up breath time.
- [gnome-mumble-push-to-talk][gnome-mumble-push-to-talk], enable Mumble push to talk.
- [cgroup-monitor][cgroup-monitor], display cgroup resources usage.

# Usage

TBD.

# References

Upstream documentation: https://gjs.guide/extensions/
Helpfull diagram: https://gjs.guide/extensions/overview/architecture.html#overview

## St

CSS and Gtk-like additions for Clutter.

- Reference: https://developer.gnome.org/st/stable/
- GJS Reference: https://gjs-docs.gnome.org/#q=st

## GNOME Shell

- GJS Reference: https://gjs-docs.gnome.org/#q=shell
- UI library: https://gitlab.gnome.org/GNOME/gnome-shell/blob/master/js/ui/

> Shell provides a global object: https://gjs-docs.gnome.org/#q=Shell.Global

## Gnome Shell Extension

- Guide: https://gjs.guide/extensions/development/creating.html
- Doc: https://wiki.gnome.org/Projects/GnomeShell/Extensions

> Extension UI is built with Clutter and St. However preferences widget is built with Gtk4.

Other usefull guides:

- https://gitlab.com/justperfection.channel/how-to-create-a-gnome-shell-extension
- https://www.codeproject.com/Articles/5271677/How-to-Create-A-GNOME-Extension

# Changes

## 0.1

- Initial release.

[purescript]: https://www.purescript.org/
[autochill]: https://github.com/TristanCacqueray/autochill
[gnome-mumble-push-to-talk]: https://github.com/TristanCacqueray/gnome-mumble-push-to-talk
[cgroup-monitor]: https://github.com/TristanCacqueray/cgroup-monitor
