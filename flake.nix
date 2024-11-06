{
  description = "Nixos flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };
  outputs = { self, nixpkgs }@inputs: let
    hostname= "nixospi";
    system = "aarch-linux";
  in {
    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit hostname system inputs; };
        inherit system;
        modules = [ ./configuration.nix ];
      };
    };
  };
}
