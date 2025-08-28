{lib, ...}: {
  systems = lib.mkDefault ["x86_64-linux"];
  perSystem = {pkgs, ...}: {
    devShells.default = with pkgs;
      mkShell {
        packages = [];
      };
    formatter = pkgs.alejandra;
  };
}
