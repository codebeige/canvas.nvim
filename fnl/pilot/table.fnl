(fn read-only [t]
  (setmetatable
    {}
    {:__index
     t
     :__newindex
     (fn [_ k _]
       (error (string.format "can't set '%s' on read-only table" k) 2))}))

(fn with-defaults [t defaults]
  (setmetatable t {:__index defaults}))

(fn copy [t]
  (collect [k v (pairs t)] k v))

(fn clear! [t]
  (each [k _ (pairs t)] (tset t k nil))
  t)

(fn merge! [t ...]
  (each [_ t* (ipairs [...])]
    (each [k v (pairs t*)]
      (tset t k v)))
  t)

(fn reset! [t t*]
  (-> t clear! (merge! t*)))

{: clear!
 : copy
 : merge!
 : read-only
 : reset!
 : with-defaults}
