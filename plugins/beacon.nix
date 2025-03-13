{ lua, fetchFromGitHub, neovimUtils }:
let
  beacon = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "beacon";
    version = "2.0.0";
    src = fetchFromGitHub {
      owner = "DanilaMihailov";
      repo = "beacon.nvim";
      rev = "098ff96c33874339d5e61656f3050dbd587d6bd5";
      hash = "sha256-x/79mRkwwT+sNrnf8QqocsaQtM+Rx6BUvVj5Nnv5JDY=";
    };
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    installPhase = ''
      mkdir -p $out/lua
      cp -r lua/. $out/lua/
    '';

    meta = {
      homepage = "https://github.com/DanilaMihailov/beacon.nvim";
      description =
        "Whenever cursor jumps some distance or moves between windows, it will flash so you can see where it is";
      license.fullName = "MIT";
    };
  }));
  plugin = (neovimUtils.buildNeovimPlugin { luaAttr = beacon; });
in {
  inherit plugin;
  config = ''
    require('beacon').setup({
      enabled = true, --- (boolean | fun():boolean) check if enabled
      speed = 2, --- integer speed at wich animation goes
      width = 40, --- integer width of the beacon window
      winblend = 70, --- integer starting transparency of beacon window :h winblend
      fps = 60, --- integer how smooth the animation going to be
      min_jump = 10, --- integer what is considered a jump. Number of lines
      cursor_events = { 'CursorMoved' }, -- table<string> what events trigger check for cursor moves
      window_events = { 'WinEnter', 'FocusGained' }, -- table<string> what events trigger cursor highlight
      highlight = { bg = 'white', ctermbg = 15 }, -- vim.api.keyset.highlight table passed to vim.api.nvim_set_hl
    })
  '';
  type = "lua";
}

