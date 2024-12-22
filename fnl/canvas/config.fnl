(var !opts {})

(local defaults
  {:enable? true
   :fennel "fennel"})

(fn with-defaults [t]
  (let [t* (collect [k v (pairs t)] k v)]
    (collect [k v (pairs defaults) &into t*]
      (values
        k
        (case (. t* k)
          v* v*
          _ v)))))

(fn reset! [opts]
  (set !opts (with-defaults opts)))

(fn enable? []
  !opts.enable?)

(fn require-fennel []
  (require !opts.fennel))

{: enable?
 : require-fennel
 : reset!}
