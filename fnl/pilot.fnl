(local commands (require :pilot.commands))

(fn setup [_]
  (set vim.g.conjure#filetype#fennel :pilot.client.repl)
  (vim.api.nvim_create_user_command :Fnl commands.eval {:nargs 1}))

{: setup}
