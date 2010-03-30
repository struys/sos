(module main scheme
  (require net/url)
  (require mzlib/pregexp)
  (require web-server/http/request-structs)
  (provide interface-version timeout start)
  
  (define interface-version 'v1)
  
  (define timeout +inf.0)
  
  ; start : request -> response
  (define (start initial-request)
    `(html (head (title "A Test Page"))
           (body ([bgcolor "white"])
                 (p "This is a simple module servlet.")
		 (p ,(third (pregexp-split #rx"/" (url->string (request-uri initial-request)))))
                 (p ,(fourth (pregexp-split #rx"/" (url->string (request-uri initial-request)))))
                 (p ,(begin (dynamic-require (build-path (string-append "/Users/kenstruys/sos/servlets/" 
                                                                         (third (pregexp-split #rx"/" (url->string (request-uri initial-request)))) ".ss")) 
                                             (string->symbol (fourth (pregexp-split #rx"/" (url->string (request-uri initial-request))))))))))))

