{
  description = "Test repository with Garnix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    garnix-lib.url = "github:garnix-io/garnix-lib";
  };

  nixConfig = {
    extra-substituters = [ "https://cache.garnix.io" ];
    extra-trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
  };

  outputs = { self, nixpkgs, flake-utils, garnix-lib }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.writeTextFile {
          name = "test";
          text = "Hello from Garnix!";
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.nix pkgs.git ];
        };
      }
    ) // {
      # Configuración específica de Garnix
      garnix = {
        deployBranch = "main";
      };
    };
}
