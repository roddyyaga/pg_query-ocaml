(** A utility to parse PostgreSQL code *)

open Core

let get_contents = function
  | "-" -> In_channel.input_all In_channel.stdin
  | filename -> In_channel.read_all filename

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
  let status = List.fold ~init:0 ~f files in
  exit status

let command =
  Command.basic ~summary:"Parses PostgreSQL"
    ~readme:(fun () ->
      "Given a list of files, parses each of them as PostgreSQL and prints\n\
       either the parsetree or an error message for each. Exits with code 0\n\
       if all files were successfully parsed and with code 1 otherwise. If no\n\
       files are provided, reads from stdin.")
    Command.Let_syntax.(
      let%map_open files = anon (sequence ("filename" %: Filename.arg_type)) in
      fun () -> match files with [] -> do_parse [ "-" ] | _ -> do_parse files)

let () = Command.run ~version:"1.0" ~build_info:"RWO" command
