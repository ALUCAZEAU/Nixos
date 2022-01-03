# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./services.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.devices = [ "/dev/sda" ];
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.enableCryptodisk = true;
  boot.loader.supportsInitrdSecrets = true;
#  boot.loader.grub.efiSupport = true;
 # boot.loader.efi.canTouchEfiVariables = true;
 # boot.loader.grub.gfxmodeEfi = "1024x768";

  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "nix201"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp0s29u1u2.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  nixpkgs.config.allowUnfree = true;

  networking.firewall.enable = true;

  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

fonts = {
  fontDir.enable = true;
  enableGhostscriptFonts = true;
  fonts = with pkgs; [
    corefonts
    vistafonts
    inconsolata
    terminus_font
    proggyfonts
    dejavu_fonts
    font-awesome-ttf
    font-awesome
    nerdfonts
    source-code-pro
    source-sans-pro
    source-serif-pro
  ];
};


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
   sound.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;

  system.stateVersion = "21.11"; # Did you read the comment?
  users = {
    #users.ntp.group = "ntp";
    groups.ntp = {};
    defaultUserShell = "/run/current-system/sw/bin/fish";
    extraUsers.alexandre = {
      isNormalUser = true;
      home = "/home/alexandre";
      description = "alexandre";
      extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "scanner" "
lp" ];
      hashedPassword = "$6$7m77oPQxa$W9YnRLo1X2eqztBHwpoH8diHGkBno5O39AMyL9Qm8y8I6uW63H2Nwx4p239OG5zhOxA8J1lZvHTQ3hKPSP9mT/";
    };
  };

   environment.systemPackages = with pkgs; [
    home-manager
    neovim
    git
    tmux
    ncdu
    rclone
    borgbackup
    openssl
    lftp
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  #   firefox
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  services.fstrim.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}

