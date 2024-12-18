{
  description = "Nixos flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    staticSite.url = "github:MartV0/personal-site";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, staticSite, sops-nix }@inputs: let
    hostnamepi= "nixospi";
    hostnamenuc= "nixos-nuc";
    system_aarch = "aarch-linux";
    system_x86 = "x86_64-linux";
    username = "martijn"; # TODO: vervang martijn overal
    flakePath = "/home/${username}/.flake";
  in {
    nixosConfigurations = {
      ${hostnamepi} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit flakePath inputs staticSite; hostname=hostnamepi; system=system_aarch; };
        system = system_aarch;
        modules = [ ./machines/pi4/configuration.nix sops-nix.nixosModules.sops ];
      };
      ${hostnamenuc} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit flakePath inputs staticSite; hostname=hostnamenuc; system=system_x86; };
        system = system_x86;
        modules = [ ./machines/nuc/configuration.nix sops-nix.nixosModules.sops ];
      };
    };
  };
}
