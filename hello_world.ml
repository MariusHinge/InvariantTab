let help_msg = "output a warm welcome message to the user"

module Self = Plugin.Register
  (struct
    let name = "hello world"
    let shortname = "hw"
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