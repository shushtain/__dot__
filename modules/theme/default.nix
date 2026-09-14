{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.theme;
in
{
  options = {
    modules.theme.enable = lib.mkEnableOption "theme";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.gtk3
      pkgs.gtk4
    ];

    # XXX:
    qt = {
      enable = true;
      # platformTheme = "qt5ct";
      platformTheme = "gnome";
      style = "adwaita-dark";
    };
  };

}
