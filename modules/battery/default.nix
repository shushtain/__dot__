{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.battery;
in
{
  options = {
    modules.battery.enable = lib.mkEnableOption "battery";
  };

  config = lib.mkIf mod.enable {
    systemd.user.services.discharge = {
      description = "Battery discharge monitor";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      path = [
        pkgs.coreutils
        pkgs.dunst
        pkgs.hyprshade
        pkgs.bash
      ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "%h/.bin/discharge.sh";
      };
    };

    systemd.user.timers.discharge = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnActiveSec = "1s";
        OnUnitActiveSec = "30s";
      };
    };
  };
}
