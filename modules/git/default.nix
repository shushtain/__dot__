{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.git;
in
{
  options = {
    modules.git.enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.git
      pkgs.serie
      pkgs.git-cliff
      pkgs.delta
      pkgs.github-cli
    ];
  };
}
