(lang dune 2.0.1)

(name pg_query)

(version 0.9.7)

(source
 (github roddyyaga/pg_query-ocaml))

(documentation
 "https://roddyyaga.github.io/pg_query-ocaml/pg_query-ocaml/index.html")

(license MIT)

(authors "Roddy MacSween <github@roddymacsween.co.uk>")

(maintainers "Roddy MacSween <github@roddymacsween.co.uk>")

(generate_opam_files true)

(package
 (name pg_query)
 (synopsis "Bindings to libpg_query for parsing PostgreSQL")
 (description
  "OCaml bindings to libpg_query for parsing PostgreSQL, and a command-line tool that uses them")
 (depends
  (ocaml
   (>= 4.07))
  (dune
   (>= 2.0))
  cmdliner
  ctypes
  ctypes-foreign
  ppx_deriving
  (alcotest :with-test)))
