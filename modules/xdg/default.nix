{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.xdg;
in
{
  options = {
    modules.xdg.enable = lib.mkEnableOption "xdg";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.xdg-utils
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-termfilechooser
      pkgs.xdg-terminal-exec
    ];

    xdg.autostart.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-termfilechooser
      ];
      config.common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
    };

    environment.sessionVariables = {
      GTK_USE_PORTAL = "1";
    };
  };
}
