(local log (require :conjure.log))

(local buf-suffix ".fnl")
(local comment-prefix "; ")

(fn eval-str [{: code : on-result}]
  (let [fennel (require :fennel)
        result (-> code fennel.eval fennel.view)]
    (on-result result)
    (log.append [result])))

(comment
  (+ 5 7))

{: buf-suffix
 : comment-prefix
 : eval-str}
