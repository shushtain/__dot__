{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.sync;
in
{
  options = {
    modules.sync.enable = lib.mkEnableOption "sync";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.insync
    ];
  };
}
