(fn eval [{: args}]
  (let [fennel (require :fennel)]
    (-> args fennel.eval fennel.view vim.print)))

{: eval}
