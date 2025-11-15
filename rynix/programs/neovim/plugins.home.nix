{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config.programs.neovim.plugins = with pkgs.vimPlugins; (
    mkIf config.programs.neovim.enable [
      {
        plugin = guess-indent-nvim;
        config = "require('guess-indent').setup {}";
        type = "lua";
      }
      {
        plugin = multicursor-nvim;
        config = ''
          local mc = require('multicursor-nvim')
          mc.setup()
          vim.keymap.set({"n", "x"}, "<A-n>", function() mc.matchAddCursor(1) end)
          vim.keymap.set("n", "<A-leftmouse>", mc.handleMouse)
          vim.keymap.set("n", "<A-leftdrag>", mc.handleMouseDrag)
          vim.keymap.set("n", "<A-leftrelease>", mc.handleMouseRelease)
        '';
        type = "lua";
      }
      {
        plugin = nvim-spider;
        config = ''
          local spider = require('spider')
          spider.setup {}
          vim.keymap.set({"n", "o", "x"}, "]w", function() spider.motion('w') end)
          vim.keymap.set({"n", "o", "x"}, "]e", function() spider.motion('e') end)
          vim.keymap.set({"n", "o", "x"}, "]b", function() spider.motion('b') end)
        '';
        type = "lua";
      }
      {
        plugin = nvim-surround;
        config = "require('nvim-surround').setup {}";
        type = "lua";
      }
    ]
  );
}
