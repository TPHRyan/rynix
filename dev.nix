{lib, ...}: {
  systems = lib.mkDefault ["x86_64-linux"];
  perSystem = {
    pkgs,
    inputs',
    ...
  }: let
    agenix = inputs'.agenix.packages.default;
  in {
    devShells.default = with pkgs;
      mkShell {
        packages = [
          agenix
        ];
      };
    formatter = pkgs.alejandra;
  };
}
