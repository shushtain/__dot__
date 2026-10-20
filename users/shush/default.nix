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
    (mod ../../modules/blender)
    (mod ../../modules/bluetooth)
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
    (mod ../../modules/freecad)
    (mod ../../modules/fuzzel)
    (mod ../../modules/git)
    (mod ../../modules/hypr)
    (mod ../../modules/ide)
    (mod ../../modules/micro)
    (mod ../../modules/mpv)
    (mod ../../modules/nvim)
    (mod ../../modules/scrcpy)
    (mod ../../modules/share)
    (mod ../../modules/signal)
    (mod ../../modules/sync)
    (mod ../../modules/telegram)
    (mod ../../modules/theme)
    (mod ../../modules/whatsapp)
    (mod ../../modules/xdg)
    (mod ../../modules/yazi)
    (mod ../../modules/gog)
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
      pkgs.brightnessctl
      pkgs.font-manager
      pkgs.imagemagick
      pkgs.pandoc
      pkgs.playerctl
      pkgs.rqbit
      pkgs.stow
      pkgs.systemctl-tui
      pkgs.trash-cli
      pkgs.typst
      pkgs.vim
      pkgs.wev
      pkgs.wiremix
      pkgr.shattered-pixel-dungeon
      pkgs.audacity
      pkgs.openvpn
      # pkgs.heroic
    ];
  };
}
