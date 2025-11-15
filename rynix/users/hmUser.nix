{
  config.perRynixConfiguration = {
    users.perUser = {user, ...}: {
      home = args: {
        config._module.args = {currentUser = user;};
      };
    };
  };
}
