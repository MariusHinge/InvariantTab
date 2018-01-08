let help_msg = "This is the Invariant Tab module"

module Self = Plugin.Register
  (struct
    let name = "Invariant Tab"
    let shortname = "IT"
    let help = help_msg
  end)

let run () = 
  Self.result "Hello world!";
  Self.feedback ~level:2 "Writing in 'hello.out'...";
  let chan = open_out "hello.out" in 
  Printf.fprintf chan "Hello world!\n";
  close_out chan
;;

let () = Db.Main.extend run;;