let
  identitySettings = {
    uid = 1000;
    groups = ["input" "wheel"];
    details = {
      name = "Ryan Paroz";
      email = "ryan.paroz@gmail.com";
    };
  };
  securitySettings = {
    hashedPasswordSecret.path = "passwd/ryan.age";
    authorizedKeys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCng7y6yBRzF0N4Uc44CelBuM7D9W9jpLfa4IE8SQwjQ863w5TiCJZG3RS8i8hHlXjHSuHPgnAk6fZYEHEYCC6gJpot1MFWHpUsg4WdRFA8Pv9DN8x7jLm/DpwaqONW5FLWxVSR/VGUYpNzhq6ebS3A2304rciJQ6Qf4S1+/qGunXqnSGq3WWR9Q/iWasc7b2G7lLL8BOOfIsKRwG/sIk9pJUxax7MR0CpvsTXs6VKk2aoNXzOW60REAH66qwNtiq+zpXTn0aYim7g0MyO2U2whdWWDDskRz99jd0SyFbSfoEPHQS/eQB1glPLOsi4uCCAA5gVzugOy2EV2z59LLOEXEn3zvB3lIR1HJp7kl96sNNyS/shuCjmGzb6htZQyABvQx6bTfnn7n499ypT7bPHknciQeuYdDPJG4wqB1E/swI6JQ0cUR+pKqK6b94VSZtgDo0X766FloNN5ju9CpZVnrixYR3VDDTQg4KI5jaw9XM2X+5n+CCIZeYBF55Bk3lE= ryan@Ry-Zen"
    ];
  };
  homeManagerConfig = {
    home.stateVersion = "25.11"; # Don't do it
  };
in {
  rynix.users.ryan =
    identitySettings
    // securitySettings
    // {
      home = homeManagerConfig;
    };
}
