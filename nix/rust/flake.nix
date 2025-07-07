{
  description = "Rust dev environment with Nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };

        rustToolchain = pkgs.rust-bin.stable.latest.default;

        rustPkg = pkgs.rustPlatform.buildRustPackage {
          pname = "rust-nix";
          version = "0.1.0";

          src = ./.;
          cargoLock = {
            lockFile = ./Cargo.lock;
          };
        };

      in {
        devShells.default = with pkgs; mkShell {
          buildInputs = [
            rustToolchain
            rust-analyzer
            pkg-config
            openssl
            rust-analyzer
          ];

          MSG = "Welcome to Dev Environment !!";
          
          shellHook = ''
            echo $MSG
            cargo --version
          '';
        };

        packages.default = rustPkg;

        packages.dockerImage = pkgs.dockerTools.buildImage {
          name = "rust-nix";
          tag = "latest";
          contents = [ rustPkg ];

          config = {
            Cmd = [ "/bin/rst_pkg" ];
            WorkingDir = "/";
          };
        };
      });
}
