{
  description = "Test Repo with Garnix CI/CD integration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    garnix-lib.url = "github:garnix-io/garnix-lib";
  };

  nixConfig = {
    extra-substituters = [ "https://cache.garnix.io" ];
    extra-trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
  };

  outputs = { self, nixpkgs, garnix-lib }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {
        inherit system;
        pkgs = nixpkgs.legacyPackages.${system};
      });
    in
    {
      packages = forAllSystems ({ system, pkgs }: {
        default = pkgs.stdenv.mkDerivation {
          name = "test-repo";
          src = self;
          installPhase = ''
            mkdir -p $out
            cp -r . $out/
          '';
        };
      });

      devShells = forAllSystems ({ system, pkgs }: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nix
            git
            bash
            ansible
            docker
          ];
        };
      });

      checks = forAllSystems ({ system, pkgs }: {
        shell-scripts = pkgs.runCommand "check-shell-scripts"
          { buildInputs = with pkgs; [ shellcheck ]; }
          ''
            shellcheck ${self}/10-*.sh || true
            shellcheck ${self}/test_*.sh || true
            touch $out
          '';
      });
    } // garnix-lib.lib.mkModules {
      modules = [ ];

      config = { pkgs, ... }: {
        garnix.deployBranch = "main";
        # Configuración adicional de Garnix
        garnix.cachixFlakeInputs = true;
      };
    };
}
