(local config (require :pilot.config))

(fn setup [opts]
  ; (let [{: client} (config.reset! opts)]
  ;   (set vim.g.conjure#filetype#fennel client))
  )

{:config config.state
 : setup}
