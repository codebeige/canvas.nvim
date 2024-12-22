(local commands (require :canvas.commands))
(local config (require :canvas.config))

(fn setup [{: enable : fennel}]
  (config.reset! {:enable? enable : fennel})
  (when config.enable?
    (set vim.g.conjure#filetype#fennel :canvas.client.repl))
  (vim.api.nvim_create_user_command :Fnl commands.eval {:nargs 1}))

{: setup}
