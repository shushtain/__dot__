{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.mpv;
in
{
  options = {
    modules.mpv.enable = lib.mkEnableOption "mpv";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.mpv
      pkgs.mpvScripts.mpris
      pkgs.yt-dlp
    ];
  };
}
