{
  config,
  lib,
  pkgs,
  pkgr,
  currentUser,
  ...
}:
let
  mod = config.modules.gog;
in
{
  options = {
    modules.gog.enable = lib.mkEnableOption "gog";
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
    ];
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;
    programs.steam.enable = true;
  };
}
