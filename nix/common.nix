{ pkgs, lib, modulesPath, nixos-hardware, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/channel.nix"
    nixos-hardware.nixosModules.apple-t2
  ];

  boot.kernelPackages = lib.mkForce (pkgs.linuxPackagesFor (pkgs.callPackage ./kernel.nix { }));

  nix.settings = {
    extra-substituters = [
      "https://t2linux.cachix.org"
    ];
    trusted-public-keys = [
      "t2linux.cachix.org-1:P733c5Gt1qTcxsm+Bae0renWnT8OLs0u9+yfaK2Bejw="
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    python3
  ];

  boot.supportedFilesystems = lib.mkForce [ "bcachefs" "btrfs" "cifs" "f2fs" "jfs" "ntfs" "reiserfs" "vfat" "xfs" ];

  # ZFS is (sometimes) broken and prevents building without this
  #nixpkgs.config.allowBroken = true;
}
