(local config (require :pilot.config))

(var preset nil)

(fn enabled? []
  (not (not preset)))

(fn enable! []
  (when (not preset)
    (set preset vim.g.conjure#filetype#fennel)
    (set vim.g.conjure#filetype#fennel :pilot.client.fennel)))

(fn disable! []
  (when preset
    (set vim.g.conjure#filetype#fennel preset)
    (set preset nil)))

(fn setup [opts]
  (config.reset! opts)
  ; (enable!)
  (config.inspect))

{:config config.state
 : disable!
 : enable!
 : enabled?
 : setup}
