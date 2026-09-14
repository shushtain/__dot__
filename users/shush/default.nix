{
  config,
  lib,
  inputs,
  pkgs,
  pkgr,
  ...
}:
let
  currentUser = "shush";
  mod =
    path:
    let
      importedModule = import path {
        inherit
          config
          lib
          pkgs
          inputs
          pkgr
          currentUser
          ;
      };
      filename = builtins.baseNameOf path;
      moduleName = lib.removeSuffix ".nix" filename;
    in
    {
      imports = [ importedModule ];
      modules.${moduleName}.enable = true;
    };
in
{
  imports = [
    (mod ../../modules/alacritty)
    (mod ../../modules/battery)
    (mod ../../modules/brave)
    (mod ../../modules/btop)
    (mod ../../modules/camera)
    (mod ../../modules/chromium)
    (mod ../../modules/cli)
    (mod ../../modules/clipboard)
    (mod ../../modules/dmentia)
    (mod ../../modules/dunst)
    (mod ../../modules/fastfetch)
    (mod ../../modules/firefox)
    (mod ../../modules/fuzzel)
    (mod ../../modules/git)
    (mod ../../modules/hypr)
    (mod ../../modules/ide)
    (mod ../../modules/micro)
    (mod ../../modules/mpv)
    (mod ../../modules/nvim)
    (mod ../../modules/scrcpy)
    (mod ../../modules/sync)
    (mod ../../modules/theme)
    (mod ../../modules/xdg)
    (mod ../../modules/yazi)
  ];

  users.users.shush = {
    isNormalUser = true;
    description = "Artem Shush";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "keyd"
      "dialout"
    ];
    packages = [
      pkgr.croc
      pkgs.blender
      pkgs.bluetui
      pkgs.brave
      pkgs.brightnessctl
      pkgs.font-manager
      pkgs.git-cliff
      pkgs.github-cli
      pkgs.imagemagick
      pkgs.magic-wormhole
      pkgs.pandoc
      pkgs.playerctl
      pkgs.rqbit
      pkgs.scrcpy
      pkgs.serie
      pkgs.signal-desktop
      pkgs.stow
      pkgs.systemctl-tui
      pkgs.telegram-desktop
      pkgs.trash-cli
      pkgs.typst
      pkgs.vim
      pkgs.wev
      pkgs.whatsapp-electron
      pkgs.wiremix
    ];
  };
}
