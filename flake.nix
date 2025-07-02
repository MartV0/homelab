{
  description = "Nixos flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    staticSite.url = "github:MartV0/personal-site";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, staticSite, agenix, home-manager}@inputs: let
    hostnamepi= "nixospi";
    hostnamenuc= "nixos-nuc";
    hostnamevm= "nixos-vm";
    system_aarch = "aarch-linux";
    system_x86 = "x86_64-linux";
    username = "martijn"; # TODO: vervang martijn overal
    flakePath = "/home/${username}/.flake";
  in {
    nixosConfigurations = {
      ${hostnamepi} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit flakePath inputs staticSite username agenix; hostname=hostnamepi; system=system_aarch; };
        system = system_aarch;
        modules = [ ./machines/pi4/configuration.nix agenix.nixosModules.default ];
      };
      ${hostnamenuc} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit flakePath inputs staticSite username agenix; hostname=hostnamenuc; system=system_x86; };
        system = system_x86;
        modules = [ ./machines/nuc/configuration.nix agenix.nixosModules.default ];
      };
      ${hostnamevm} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit flakePath inputs username agenix; hostname=hostnamevm; system=system_x86; };
        system = system_x86;
        modules = [ ./machines/vm/configuration.nix agenix.nixosModules.default ];
      };
    };
  };
}
