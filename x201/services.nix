{ config, pkgs, ... }:

{

  hardware = {
    pulseaudio = {
      enable = true;
    };
  };

  # upgrade

  programs = {
    fish.enable = true;
    ssh = {
      setXAuthLocation = true;   
      forwardX11 = true;
    };
  };


  # SERVICES
  services = {
    
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };

    ntp.enable = true;
    tlp.enable = true;

#    udev.extraRules = ''
#      ACTION=="remove", ENV{ID_VENDOR_ID}=="1050", ENV{ID_MODEL_ID}=="0407", RUN+="/usr/bin/lockscreen-all"
#    '';

    xserver = {
      enable = true;
      autorun = true;
      #desktopManager.gnome.enable = true; 
      windowManager.i3.enable = true;
      displayManager.defaultSession = "none+i3";
      layout = "fr";
      xkbOptions = "eurosign:e";
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
    };

  };

  nixpkgs.config = {

    packageOverrides = pkgs: {
      polybar = pkgs.polybar.override {
        i3Support = true;
        pulseSupport = true;
      };
    };

  };

}
