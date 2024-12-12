{
  description = "Nixos flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    staticSite.url = "github:MartV0/personal-site";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, staticSite, sops-nix }@inputs: let
    hostname= "nixospi";
    system = "aarch-linux";
    username = "martijn"; # TODO: vervang martijn overal
    flakePath = "/home/${username}/.flake";
  in {
    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit hostname system flakePath inputs staticSite; };
        inherit system;
        modules = [ ./configuration.nix sops-nix.nixosModules.sops ];
      };
    };
  };
}
