(local t (require :pilot.table))

(local defaults
  {:fennel "fennel"})

(local !state (t.with-defaults {} defaults))

(fn reset! [opts]
  (t.reset! !state opts))

(fn inspect []
  (collect [k _ (pairs defaults)]
    k (. !state k)))

{: inspect
 : reset!
 :state (t.read-only !state)}
