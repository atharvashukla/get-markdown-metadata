#lang racket


(require racket/contract json)


(define DIR-PATHS (map path->string (directory-list)))
(define OUTFILE "posts.json")


; String -> Boolean
; is it a string representing a md filename
(define/contract (markdown-file-string? file)
  (-> string? boolean?)
  (if (< (string-length file) 4)
      (error 'markdown-file-string? "filename \"~a\" is too short" file)
      (let ([s-len (string-length file)])
        (string=?  (substring file (- s-len 3) s-len) ".md"))))

; String -> String
; first line of file
(define (first-line file)
  (call-with-input-file file (λ (file) (read-line file 'any))))

; String -> True | Error
(define/contract (heading-check heading)
  (-> string? boolean?)
  (cond [(string=? heading "") (error "the heading is empty")]
        [(not (string=? (substring heading 0 1) "#")) (error "heading marker is missing")]
        [(not (string=? (substring heading 1 2) " ")) (error "no space after the heading marker")]
        [(string=? (substring heading 2) "") (error "no heading content after heading marker and space")]
        [else #true]))

; String -> String
(define (heading-trim heading)
  (substring heading 2))


(define names (filter markdown-file-string? DIR-PATHS))
(define headings (map heading-trim(filter heading-check (map first-line names))))

; - - - - - -  - 

(define (attr-maker heading name)
  (hasheq 'name name 'heading heading))

; - - - - 

(when (file-exists? OUTFILE)
  (delete-file OUTFILE))

(with-output-to-file "posts.json"
    (lambda ()
      (write-json (hasheq 'posts (map attr-maker headings names)))))


