{
  description = "@shushtain";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-rolling.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-rolling,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      allowUnfree = true;
      pkgr = import nixpkgs-rolling {
        inherit system;
        config.allowUnfree = allowUnfree;
      };
    in
    {
      nixosConfigurations.ash14 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs pkgr; };
        modules = [
          { nixpkgs.config.allowUnfree = true; }
          ./hosts/ash14
          ./users/shush
          ./users/root
        ];
      };
    };
}
