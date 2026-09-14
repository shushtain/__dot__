{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.fastfetch;
in
{
  options = {
    modules.fastfetch.enable = lib.mkEnableOption "fastfetch";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.fastfetch
    ];
  };
}
