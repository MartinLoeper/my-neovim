{ lua, fetchFromGitHub, neovimUtils }:
let
  terraform = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "terraform";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "mvaldes14";
      repo = "terraform.nvim";
      rev = "20c70da0d00dd4275a7589b6906d7881d6aaaaeb";
      hash = "sha256-5o6x5Mj2r9oDya9NjwDuvzqjsC0s47v0vkXkMlj1pJ0=";
    };
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    installPhase = ''
      mkdir -p $out/lua
      cp -r lua/. $out/lua/
    '';

    meta = {
      homepage = "https://github.com/mvaldes14/terraform.nvim";
      description = "Plan and Explore your terraform resources from nvim";
      license.fullName = "MIT";
    };
  }));
  plugin = (neovimUtils.buildNeovimPlugin { luaAttr = terraform; });
in {
  inherit plugin;
  config = ''
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.tf" },
      callback = function()
        vim.cmd("TerraformValidate")
      end,
    })
  '';
  type = "lua";
}

