{
  description = "My Neovim configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, home-manager, flake-utils, ... }: {
    homeConfigurations = flake-utils.lib.eachDefaultSystem (system:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [ ./default.nix ./devcontainer.nix ];
      });
    homeManagerModule =
      flake-utils.lib.eachDefaultSystem (system: ./default.nix);
  };
}
