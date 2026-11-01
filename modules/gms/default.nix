{
  config,
  lib,
  pkgs,
  pkgr,
  currentUser,
  ...
}:
let
  mod = config.modules.gms;
in
{
  options = {
    modules.gms.enable = lib.mkEnableOption "gms";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      (pkgr.heroic.override {
        extraPkgs =
          pkgs': with pkgs'; [
            gamescope
            gamemode
          ];
      })
      pkgr.protonup-qt
      pkgr.wine
    ];
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;
    programs.steam.enable = true;
  };
}
