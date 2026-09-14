{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.brave;
in
{
  options = {
    modules.brave.enable = lib.mkEnableOption "brave";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.brave
    ];
  };
}
