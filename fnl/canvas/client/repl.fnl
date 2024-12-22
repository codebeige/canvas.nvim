(local log (require :conjure.log))
(local repl (require :canvas.repl))
(local tree-sitter (require :conjure.tree-sitter))
(local file (require :canvas.file))

(local buf-suffix ".fnl")
(local comment-prefix "; ")

(fn comment-node? [...]
  (tree-sitter.lisp-comment-node? ...))

(fn form-node? [...]
  (tree-sitter.node-surrounded-by-form-pair-chars? ...))

(fn context [...]
  (vim.fn.expand :%:p))

(fn display-result [s]
  (log.append (vim.split s "\n" {:plain true})))

(fn display-error [ex]
  (log.append (icollect [_ line (ipairs (vim.split ex "\r?\n"))]
                (.. "; (err) " line))))

(fn display-output [s]
  (let [lines (vim.split s "\n" {:plain true})]
    (log.append (icollect [i l (ipairs lines)]
                  (when (< 1 i) (.. "; (out) " l))))))

(fn with-display-out [f ...]
  (vim.cmd.redir :=> :__canvas_nvim_out__)
  (let [[success? & result] [(pcall f ...)]]
    (vim.cmd.redir :END)
    (display-output vim.g.__canvas_nvim_out__)
    (if success? (unpack result) (error (. result 1)))))

(fn eval-str [{: code : context : on-result}]
  (case (with-display-out repl.eval-str code {: context})
    (true xs) (do
                (when on-result (on-result (table.concat xs "\n")))
                (each [_ x (ipairs xs)] (display-result x)))
    (false _ ex) (display-error ex)))

(fn eval-file [{: file-path &as opts}]
  (case (file.read file-path)
    (false ex) (display-error ex)
    (true code) (eval-str (doto opts (tset :code code)))))

(fn doc-str [opts]
  (let [opts* (collect [k v (pairs opts)] k v)]
    (set opts*.code (.. ",doc " opts.code))
    (eval-str opts*)))

{: buf-suffix
 : comment-node?
 : comment-prefix
 : context
 : doc-str
 : eval-file
 : eval-str
 : form-node?}
