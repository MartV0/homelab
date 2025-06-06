{
  description = "Nixos flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    staticSite.url = "github:MartV0/personal-site";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, staticSite, agenix, nixpkgs-unstable }@inputs: let
    hostnamepi= "nixospi";
    hostnamenuc= "nixos-nuc";
    system_aarch = "aarch-linux";
    system_x86 = "x86_64-linux";
    username = "martijn"; # TODO: vervang martijn overal
    flakePath = "/home/${username}/.flake";
      in {
    nixosConfigurations = {
      ${hostnamepi} = nixpkgs.lib.nixosSystem rec {
        specialArgs = { 
          inherit flakePath inputs staticSite username agenix;
          hostname=hostnamepi; system=system_aarch;
          pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
        };
        system = system_aarch;
        modules = [ ./machines/pi4/configuration.nix agenix.nixosModules.default ];
      };
      ${hostnamenuc} = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit flakePath inputs staticSite username agenix;
          hostname=hostnamenuc; system=system_x86;
          pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
        };
        system = system_x86;
        modules = [ ./machines/nuc/configuration.nix agenix.nixosModules.default ];
      };
    };
  };
}
