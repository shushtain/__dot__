{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.clipboard;
in
{
  options = {
    modules.clipboard.enable = lib.mkEnableOption "clipboard";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.cliphist
      pkgs.wl-clip-persist
      pkgs.wl-clipboard
      pkgs.wtype # :::
    ];
  };
}
