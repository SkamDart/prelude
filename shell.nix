with import <nixpkgs> {};
let
  haskellDeps = ps: with ps; [ base QuickCheck ];

  ghc = haskellPackages.ghcWithPackages haskellDeps;

  nixPackages = [ ghc
  		  pkgs.gdb
		  haskellPackages.cabal-install
		];
in
  pkgs.stdenv.mkDerivation {
    name = "prelude";
    buildInputs = nixPackages;
}

