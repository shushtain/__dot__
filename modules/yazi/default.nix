{
  config,
  lib,
  pkgs,
  pkgr,
  currentUser,
  ...
}:
let
  mod = config.modules.yazi;
in
{
  options = {
    modules.yazi.enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      (pkgr.yazi.override {
        _7zz = pkgr._7zz-rar;
      })
      pkgs.glib
      pkgs.ueberzugpp
      pkgs.ffmpeg
      pkgs._7zz-rar
      pkgs.jq
      pkgs.poppler
      pkgs.fd
      pkgs.ripgrep
      pkgs.fzf
      pkgs.zoxide
      pkgs.resvg
      pkgs.imagemagick
      pkgs.wl-clipboard
    ];
  };
}
