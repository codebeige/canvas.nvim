(local commands (require :canvas.commands))

(fn setup [_]
  (set vim.g.conjure#filetype#fennel :canvas.client.repl)
  (vim.api.nvim_create_user_command :Fnl commands.eval {:nargs 1}))

{: setup}
