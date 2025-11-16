{
  config.perRynixConfiguration = {
    users.perUser.home = {
      imports = [
        ./oh-my-zsh.home.nix
      ];
    };
  };
}
