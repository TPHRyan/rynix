{
  nixpkgs.allowedUnfreePackages = [
    "example-unfree-package"
  ];
  perRynixConfiguration = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      hello-unfree
    ];
    perUser.home = {
      home.file."hello.txt".text = ''
        Hello world!
      '';
    };
  };
}
