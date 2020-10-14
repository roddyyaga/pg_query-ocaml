(** A utility to parse PostgreSQL code *)

open Cmdliner

let get_contents = function
  (* | "-" -> In_channel.input_all In_channel.stdin *)
  | filename ->
      let ic = open_in filename in
      let contents = really_input_string ic (in_channel_length ic) in
      close_in ic;
      contents

let do_parse files =
  let f exit_status filename =
    let result = get_contents filename |> Pg_query.parse in
    match result with
    | Ok parse_tree ->
        print_endline parse_tree;
        exit_status
    | Error message ->
        print_endline message;
        1
  in
  let status = files |> List.fold_left f 0 in
  exit status

let info =
  let doc = "Parses PostgreSQL" in
  let man = [
    `S Manpage.s_description;
    `P "Given a list of files, parses each of them as PostgreSQL and prints\n\
        either the parsetree or an error message for each. Exits with code 0\n\
        if all files were successfully parsed and with code 1 otherwise."
  ]
  in
  Term.info "pg_check" ~version:"0.9.4" ~doc ~exits:Term.default_exits ~man

let files = 
  let doc = "A list of files to parse. If no files are provided, reads from stdin." in
  Arg.(non_empty & pos_all file [] & info [] ~docv:"FILE(S)" ~doc)

let cmd = Term.(const do_parse $ files)

let () = Term.exit @@ Term.eval (cmd, info)