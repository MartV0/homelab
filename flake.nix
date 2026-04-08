{
  description = "Nixos flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    staticSite.url = "github:MartV0/personal-site";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };
  outputs = { self, nixpkgs, staticSite, agenix, home-manager, nix-flatpak, nixpkgs-unstable }@inputs: let
    hostnamepi= "nixospi";
    hostnamenuc= "nixos-nuc";
    hostnamevm= "nixos-vm";
    hostnamepc= "nixos-gamepc";
    system_aarch = "aarch-linux";
    system_x86 = "x86_64-linux";
    username = "martijn";
    flakePath = "/home/${username}/.flake";
    createSystem = { hostname, system, modules }: nixpkgs.lib.nixosSystem rec {
        specialArgs = { 
          inherit flakePath inputs staticSite username agenix system hostname;
          pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
        };
        inherit system modules;
      };
      in {
    nixosConfigurations = {
      ${hostnamepi} = createSystem {
        hostname = hostnamepi;
        system = system_aarch;
        modules = [ ./machines/pi4/configuration.nix ];
      };
      ${hostnamenuc} = createSystem {
        hostname = hostnamenuc;
        system = system_x86;
        modules = [ ./machines/nuc/configuration.nix ];
      };
      ${hostnamevm} = createSystem {
        hostname = hostnamevm;
        system = system_x86;
        modules = [ ./machines/vm/configuration.nix ];
      };
      ${hostnamepc} = createSystem {
        hostname = hostnamepc;
        system = system_x86;
        modules = [ ./machines/game-pc/configuration.nix ];
      };
    };
  };
}
