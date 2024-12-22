(local fennel (require :fennel))

(local state
  (setmetatable {} {:__index #{}}))

(fn make-env [context]
  (doto (collect [k v (pairs _G)] k v)
    (tset :___context___ (. state context))))

(fn reset! [{: context : env}]
  (set env.___replLocals___.*1 (. state context :*1))
  (set env.___replLocals___.*2 (. state context :*2))
  (set env.___replLocals___.*3 (. state context :*3)))

(fn read-str [{: context : env} s]
  (let [setup (icollect [k (pairs (. state context))]
                (string.format "(local %s ___context___.%s)" k k))
        chunk [s]]
    (fn [_]
      (or (table.remove setup)
          (case (table.remove chunk)
            chunk (do
                    (reset! {: context : env})
                    chunk))))))

(fn save-context! [{: context : env }]
  (let [locals (collect [k v (pairs env.___replLocals___)] k v)]
    (tset state context locals)
    locals))

(fn eval-str [s opts]
  (let [context (or (?. opts :context) :canvas.user)
        env (make-env context)
        result {}]
    (fennel.repl {: env
                  :readChunk (read-str {: context : env} s)
                  :onValues #(set result.values $)
                  :onError #(set result.error [$...])})
    (if (not result.error)
      (values true result.values {: context
                                  :locals (save-context! {: context : env})})
      (values false (unpack result.error)))))

(comment
  (eval-str "(+ 4 5)")
  (eval-str "*1")
  (eval-str "(os.date)")
  (eval-str "(fn foo [x] x) foo-bar"))

(comment
  (vim.print :hello!))

{: eval-str}
