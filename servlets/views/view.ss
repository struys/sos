(module view scheme
  (provide (all-defined-out))
  
  
  (define (template content)
    `(html 
      (head)
      (body ,@content)))
  
  (define (render-post post)
    `(div ((class "blog-post"))
          (span ((class "title")) ,(vector-ref post 1))
          (span ((class "date")) ,(vector-ref post 3)))))