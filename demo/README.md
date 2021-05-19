purescript-gnome-shell demo
===========================

Start your project by copying this example directory, edit the `extension.dhall` file and run `make update`.

# Develop

Build and test the extension:

```
make dist
make install
make test
```

In the nested gnome shell, run this command: `gnome-extensions enable Demo@purescript-gjs.github.io`.
Check that this is logged: `Demo-Message: 18:18:37.269: enable called`
