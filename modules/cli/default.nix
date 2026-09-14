{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.cli;
in
{
  options = {
    modules.cli.enable = lib.mkEnableOption "cli";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.choose
      pkgs.duf
      pkgs.dust
      pkgs.eza
      pkgs.fd
      pkgs.jq
      pkgs.just
      pkgs.repgrep
      pkgs.ripgrep
      pkgs.ripgrep-all
      pkgs.sd
      pkgs.skim
      pkgs.watchexec
      pkgs.yq
    ];

    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batman
        batgrep
        batdiff
      ];
    };
  };
}
