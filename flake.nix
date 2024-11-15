{
  description = "Nixos flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    staticSite.url = "github:MartV0/personal-site";
  };
  outputs = { self, nixpkgs, staticSite }@inputs: let
    hostname= "nixospi";
    system = "aarch-linux";
  in {
    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit hostname system inputs staticSite; };
        inherit system;
        modules = [ ./configuration.nix ];
      };
    };
  };
}
