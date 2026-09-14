{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.hypr;
in
{
  options = {
    modules.hypr.enable = lib.mkEnableOption "hypr";
  };

  config = lib.mkIf mod.enable {
    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
        package = pkgs.hyprland;
      };
      hyprlock.enable = true;
    };

    users.users.${currentUser}.packages = [
      pkgs.hyprland-qt-support
      pkgs.hyprland-qtutils
      pkgs.hyprls
      pkgs.hyprpicker
      pkgs.hyprpolkitagent
      pkgs.hyprshade
      pkgs.hyprshot
      pkgs.wev
      pkgs.wf-recorder
      pkgs.slurp
    ];
  };
}
