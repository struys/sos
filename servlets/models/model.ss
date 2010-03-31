(module model scheme
  (provide (all-defined-out))
  (require (planet "sqlite.ss" ("jaymccarthy" "sqlite.plt"))
           (planet "sqlite.ss" ("soegaard" "sqlite.plt" 1 0)))
  
  (define DATABASE-PATH     (string->path "/Users/kenstruys/sos/servlets/models/listit.db"))
  (define current-database  (make-parameter #f))
  
  (define-syntax db
  (syntax-id-rules () [db (or (current-database)
                              (let ([d (open DATABASE-PATH)])
                                (current-database d)
                                d))]))
  
  (define (create-table-entries)
  (exec/ignore
   db
   #<<SQL
 CREATE TABLE post (
   id  INTEGER PRIMARY KEY,
   title     TEXT,
   path      TEXT,
   pubdate   TIMESTAMP)
SQL
   ))

(define (drop-table-entries)
  (exec/ignore db "DROP TABLE entries"))


(define (insert-post title path pubdate)
  (insert db (sql (INSERT INTO post (title path pubdate)
                          VALUES (,title ,path ,pubdate)))))

(define (get-page n)
  (select db (sql (SELECT (id title path pubdate)
                          FROM post
                          ORDER-BY (pubdate DESC)
                          LIMIT 10 OFFSET ,(+ 1 (* 10 n)))))))

