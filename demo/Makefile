# TODO: replace dependency by a known location
PGS := "../package.dhall"

.PHONE: update
update:
	echo "($(PGS)).render ./extension.dhall" | dhall to-directory-tree --output .
