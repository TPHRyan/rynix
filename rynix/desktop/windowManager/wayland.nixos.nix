{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types;
in {
  options.windowManager = {
    isWayland = mkOption {
      type = types.bool;
      default = false;
      readOnly = true;
      description = ''
        True if the current window manager uses the Wayland protocol.
      '';
    };
  };
  config = mkIf config.windowManager.isWayland {
    environment = {
      systemPackages = with pkgs; [
        kdePackages.qtwayland
        libsForQt5.qtwayland
        wl-clipboard
      ];
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
      pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
      ];
      security.polkit.enable = true;
    };
  };
}
