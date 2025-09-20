{
  description = "Nixos flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    staticSite.url = "github:MartV0/personal-site";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };
  outputs = { self, nixpkgs, staticSite, agenix, home-manager, nix-flatpak, nixpkgs-unstable }@inputs: let
    hostnamepi= "nixospi";
    hostnamenuc= "nixos-nuc";
    hostnamevm= "nixos-vm";
    system_aarch = "aarch-linux";
    system_x86 = "x86_64-linux";
    username = "martijn";
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
      ${hostnamevm} = nixpkgs.lib.nixosSystem {
        specialArgs = { 
          inherit flakePath inputs username agenix; 
          hostname=hostnamevm; system=system_x86;
          pkgs-unstable = import nixpkgs-unstable { system=system_x86; config.allowUnfree = true; };
        };
        system = system_x86;
        modules = [ ./machines/vm/configuration.nix agenix.nixosModules.default nix-flatpak.nixosModules.nix-flatpak];
      };
    };
  };
}
