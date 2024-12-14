(fn read [f]
  (case (vim.uv.fs_open f :r 438)
    f* (let [(success? result)
             (case-try
               (vim.uv.fs_fstat f*)
               {: size} (vim.uv.fs_read f* size 0)
               s (values true s)
               (catch
                 (nil ex) (values false ex)))]
         (vim.uv.fs_close f*)
         (values success? result))
    (nil ex) (values false ex)))

(comment
  (let [{: path} (require :fennel)]
    [(vim.split path ";") (vim.fn.expand :%:.)]))

{: read}
