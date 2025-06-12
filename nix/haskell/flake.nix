{
    description = "Haskell Dev Environment";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system:
            let 
                pkgs = nixpkgs.legacyPackages.${system};
                haskellPackages = pkgs.haskellPackages;
            in
            {
                devShells.default = pkgs.mkShell {
                    packages = with pkgs; [
                        haskellPackages.ghc
                        haskellPackages.cabal-install
                        haskellPackages.haskell-language-server
                    ];

                shellHook = ''
                    echo "Welcome Haskell Dev Environment"
                    echo "GHC version: $(ghc --version)"
                '';                
                };
            });
}
