{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [
          pkgs.gnumake
          pkgs.dhall
          pkgs.dhall-json
          pkgs.gjs
          pkgs.spago
          pkgs.purescript
          pkgs.esbuild
        ];
      };
    };
}
