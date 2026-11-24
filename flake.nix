{
  description = "SolidCraft AppImage packaged for NixOS";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  outputs = { nixpkgs, ... }: {
    packages.x86_64-linux = rec {
      solidcraft = nixpkgs.legacyPackages.x86_64-linux.callPackage ./package.nix { };
      default = solidcraft;
    };
    nixosModules.default = { config, lib, pkgs, ... }: {
      options.programs.solidcraft.enable = lib.mkEnableOption "SolidCraft";
      config = lib.mkIf config.programs.solidcraft.enable {
        environment.systemPackages = [ (pkgs.callPackage ./package.nix { }) ];
      };
    };
  };
}
