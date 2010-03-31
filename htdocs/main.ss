(module main scheme
  (require net/url)
  (require mzlib/pregexp)
  (require web-server/http/request-structs)
  (provide interface-version timeout start)
  
  (define interface-version 'v1)
  
  (define timeout +inf.0)
  
  ; start : request -> response
  (define (start initial-request)
    (let* ((uri-split (pregexp-split #rx"/" (url->string (request-uri initial-request))))
           (method (dynamic-require (build-path (string-append (path->string (current-directory))
                                                               "../servlets/controllers/" 
                                                               (third uri-split) ".ss")) 
                                    (string->symbol (fourth uri-split)))))
                              (apply method (cddddr uri-split)))))