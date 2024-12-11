(local t (require :pilot.table))

(local defaults
  {:client "pilot.client.fennel"
   :fennel "fennel"})

(fn with-defaults [opts]
  (vim.tbl_extend :keep opts defaults))

(local !state (with-defaults {}))

(fn inspect []
  (collect [k _ (pairs defaults)]
    k (. !state k)))

(fn reset! [opts]
  (t.reset! !state (with-defaults opts)))

{: inspect
 : reset!
 :state (t.read-only !state)}
