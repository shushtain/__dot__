{
  pkgs,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];
  system.stateVersion = "26.05";

  boot = {
    kernelParams = [
      "acpi_backlight=native"
      "amdgpu.abmlevel=0"
    ];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 6;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = {
      ntfs = true;
      btrfs = true;
      f2fs = true;
      exfat = true;
    };
  };

  networking = {
    hostName = "ash14";
    networkmanager.enable = true;
  };

  nix = {
    settings = {
      max-substitution-jobs = 128;
      cores = 0;
      max-jobs = "auto";
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  time = {
    timeZone = "Europe/Kyiv";
    hardwareClockInLocalTime = false;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = "all";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "15m";
    SuspendState = "mem";
  };

  services = {
    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 10;
      percentageAction = 5;
      criticalPowerAction = "Hibernate";
    };
    auto-cpufreq.enable = true;
    libinput.enable = true;
    logind = {
      settings = {
        Login = {
          HandleLidSwitch = "lock";
          HandlePowerKey = "suspend-then-hibernate";
          HandlePowerKeyLongPress = "poweroff";
          IdleAction = "ignore";
        };
      };
    };
    # TODO: move to user service
    playerctld.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    smartd.enable = true;
    dbus = {
      enable = true;
      apparmor = "enabled";
      implementation = "broker";
    };
    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
    };
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
    };
    keyd = {
      enable = true;
      keyboards.default.settings = {
        main = {
          capslock = "esc";
          "f23+leftshift+leftmeta" = "rightcontrol";
        };
        shift = {
          capslock = "capslock";
        };
      };
    };
  };

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        libx11
        libxcursor
        libxrandr
        libxi
        libxkbcommon
        wayland
        libGL
        libv4l
      ];
    };
    bash = {
      enable = true;
      enableLsColors = true;
      completion.enable = true;
    };
  };

  environment = {
    systemPackages = [
      pkgs.neovim
      pkgs.git
      pkgs.curl
      pkgs.wget
      pkgs.dosfstools
      pkgs.mtools
      pkgs.gpart
      pkgs.gptfdisk
      pkgs.parted
      pkgs.vulkan-tools
      pkgs.libva-utils
      pkgs.man-db
      pkgs.fzf
      pkgs.zoxide
      pkgs.killall
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    packages = [
      pkgs.jetbrains-mono
      pkgs.noto-fonts
      pkgs.noto-fonts-color-emoji
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.inter
    ];
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    fontconfig = {
      enable = true;
      cache32Bit = true;
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "JetBrains Mono NL" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  console = {
    enable = true;
    earlySetup = true;
    colors = [
      "1a1a1a"
      "fc725d"
      "8bab60"
      "c8904b"
      "72a4c7"
      "b980c7"
      "62b599"
      "b3b3b3"
      "666666"
      "ff907e"
      "9ec585"
      "dbaa6e"
      "91bcdb"
      "ce9ddb"
      "83cbb3"
      "cccccc"
    ];
  };
}
