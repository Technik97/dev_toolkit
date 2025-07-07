{
    description = "Go development environment";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system:
            let 
                pkgs = import nixpkgs {
                    inherit system;
                };
            in {
                devShells.default = pkgs.mkShell {
                    name = "go-dev-shell";

                    buildInputs = [
                        pkgs.go
                        pkgs.gopls
                        pkgs.go-tools
                    ];

                    shellHook = ''
                        echo "Welcome to Go dev shell!"
                        export GOPATH=$PWD/.gopath
                        export GOBIN=$GOPATH/bin
                        export PATH=$PATH:$GOBIN
                        mkdir -p $GOPATH
                    '';
                };
            });
}
