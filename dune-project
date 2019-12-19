(lang dune 2.0.1)
(name pg_query-ocaml)
(version 0.9)
(source (github roddyyaga/pg_query-ocaml))
(documentation "https://roddyyaga.github.io/ocoi")
(license MIT)
(authors "Roddy MacSween <github@roddymacsween.co.uk>")
(maintainers "Roddy MacSween <github@roddymacsween.co.uk>")
(generate_opam_files true)

(package
(name pg_query-ocaml)
(synopsis "Bindings for pg_query for parsing PostgreSQL")
(depends
dune
core
ctypes
ctypes.foreign
ppx_deriving
)
)
