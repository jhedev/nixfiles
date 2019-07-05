{ config, pkgs, ... }:

let meta = import ../../hosts/current/meta.nix;
in {

  imports = [
    <nixos-hardware/apple/macbook-pro/12-1>
    ../../services/default.nix
    <home-manager/nixos>
  ];

  # fix sound
  boot.extraModprobeConfig = ''
    options libata.force=noncq
    options snd_hda_intel index=0 model=intel-mac-auto id=PCH
    options snd_hda_intel index=1 model=intel-mac-auto id=HDMI
    options snd_hda_intel model=mbp101
  '';

  tnix.services = {
    autorandr.enable = true;
    common.enable = true;
    common.offline = false;
    emacs.enable = true;
    fonts.enable = true;
    homeManager.enable = true;
    light.enable = true;
    user.enable = true;
    user.name = "tjdev";
    programs.enable = true;
    sound.enable = true;
    tty.enable = true;
    x11.enable = true;
    x11.autorun = true;
    wireguard.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.kernelParams = [ "hid_apple.swap_opt_cmd=1" ];

  services.mbpfan.enable = !meta.vm_guest;

  networking.hostId = "c79265a0";
  networking.hostName = meta.hostName;
  networking.wireless.enable = true;

  services.xserver.libinput.enable = true;
  services.xserver.libinput.tapping = false;
  services.xserver.videoDrivers = [ "intel" ];

  services.xserver.xrandrHeads = [
    {
      output = "eDP1";
      monitorConfig = ''
        DisplaySize 286 179
      '';
    }
    {
      output = "HDMI2";
      monitorConfig = ''
        DisplaySize 598 336
      '';
    }
  ];
  services.xserver.resolutions = [
    {
      x = 2560;
      y = 1600;
    }
    {
      x = 2560;
      y = 1440;
    }
  ];

}
