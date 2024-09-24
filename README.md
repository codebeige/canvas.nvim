# 🪢 pilot.nvim

Bring your own [fennel][1] to [conjure][2].

This plugin provides a custom conjure client that can be configured to use a
specific version of fennel for compilation and evaluation. It defaults to
the top level "fennel" module (i.e., `(require :fennel)`).

# Usage

With `lazy.nvim` just add the plugin to your configuration:

```lua
-- $XDG_CONFIG_HOME/nvim/lua/plugins/pilot.nvim.lua

return {
  "codebeige/pilot.nvim",

  -- the following entries are only required when deviating from the defaults:
  dependencies = { "codebeige/rig.nvim" },
  opts = { fennel = "fennel" },
}
```

---
Copyright ©2024 Tibor Claassen under the [MIT License](LICENSE)

[1]: https://fennel-lang.org
[2]: https://github.com/Olical/conjure
