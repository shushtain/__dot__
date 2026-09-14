{
  config,
  lib,
  pkgs,
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
      (pkgs.yazi.override {
        _7zz = pkgs._7zz-rar;
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
