{
  imports = [
    ./options.nix
    ./perUser.nix
    ./secrets.nix
    ./users.nix
  ];
  config.perRynixConfiguration = {
    users = {
      mutableUsers = false;
      users.root = {};
    };
  };
}
