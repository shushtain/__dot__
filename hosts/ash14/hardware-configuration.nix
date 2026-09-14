{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = {
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
      systemd.enable = true;
    };
    kernelParams = [ "resume_offset=12949504" ];
    resumeDevice = "/dev/disk/by-uuid/4c16b727-4ad2-4ef4-9d5b-2f9abd9ee09f";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4c16b727-4ad2-4ef4-9d5b-2f9abd9ee09f";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4E95-7F3C";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  powerManagement.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
