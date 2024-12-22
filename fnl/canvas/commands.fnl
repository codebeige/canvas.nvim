(local config (require :canvas.config))

(fn eval [{: args}]
  (let [fennel (config.require-fennel)]
    (-> args fennel.eval fennel.view vim.print)))

{: eval}
