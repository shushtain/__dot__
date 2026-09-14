{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.camera;
in
{
  options = {
    modules.camera.enable = lib.mkEnableOption "camera";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.snapshot
      pkgs.cameractrls
      pkgs.cameractrls-gtk3
    ];
  };
}
