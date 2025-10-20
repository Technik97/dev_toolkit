{
  description = "Devshell for Ruby";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils}: 
    flake-utils.lib.eachDefaultSystem (system: 
      let pkgs = import nixpkgs {
        inherit system;
      };
      in {
        devShells.default = pkgs.mkShell {
          name = "ruby-dev-shell";

          packages = with pkgs; [
            ruby_3_4
            bundler
          ];

          shellHook = ''
            echo "Entering Ruby development shell..."
            echo "Ruby version: $(ruby -v)"
            echo "Bundler version: $(bundler -v)"
          '';    
        };
      }
    );
}
