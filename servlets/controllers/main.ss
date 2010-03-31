(module main scheme
  
  (require "../models/model.ss")
  (require "../views/view.ss")
  
  (define (index page)
    (template (map render-post (cdr (get-page (string->number page))))))
  
  (provide (all-defined-out)))
