{
  description = "Hans's Nix System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    darwin,
    home-manager,
    neovim-nightly,
    ...
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-darwin"
    ];

    nixpkgsFor = system: import nixpkgs {
      inherit system;
      overlays = [ ]; # Add your overlays here if needed
    };

    darwinSystem = {user, arch ? "aarch64-darwin"}:
      darwin.lib.darwinSystem {
        system = arch;
        modules = [
          ./darwin/darwin.nix
          home-manager.darwinModules.home-manager
          {
            _module.args = { inherit inputs; };
            home-manager = {
              users.${user} = import ./home-manager;
              extraSpecialArgs = {
                neovim-nightly = neovim-nightly;
              };
            };
            users.users.${user}.home = "/Users/${user}";
            nix.settings.trusted-users = [ user ];
          }
        ];
      };
  in
  {
    darwinConfigurations = {
      "the-machine" = darwinSystem {
        user = "hans";
      };
    };

    devShells = forAllSystems (system:
      let
        pkgs = nixpkgsFor system;
      in
        {
        default = pkgs.mkShell {
          name = "config-environment";

          buildInputs = with pkgs; [
            lua-language-server
          ];
        };
      }
    );
  };
}
