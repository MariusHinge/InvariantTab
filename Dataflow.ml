open Cil_types;;

let help_msg = "This is the Invariant Tab module"

module Self = Plugin.Register
  (struct
    let name = "Invariant Tab"
    let shortname = "IT"
    let help = help_msg
  end)

(* Treillis *)
(* TODO - Type & Union & Equal & Diff*)
type Prop = 
  | Top
  | Bottom
;;

let union a b = 
  match (a;b) with
  | (Top,_) -> Top
  | (_, Top) -> Top
  | (Bottom, _) -> Bottom
  | (_, Bottom) -> Bottom
;;

let diff a b = 
  match (a;b) with
  | (Top,Top) -> true
  | (Top,_) -> false
  | (Bottom, Bottom) -> true
  | (Bottom, _) -> false
;;

(* Sémantique *)
(*TODO - Type block (liste d'instruction de la boucle)*)
let analyse_boucle block phi = 
  Printer.pp_instr out block
;;


let rec looper phi_1 phi_2 block =  
  if (diff phi_1 phi_2) then let phi = (union phi_1 phi_2) in looper (analyse_boucle block phi) phi
  else phi_1
;;

let print_stmt out = function
  | Instr i -> Printer.pp_instr out i
  | Return _ -> Format.pp_print_string out "<return>"
  | Goto _ -> Format.pp_print_string out "<goto>"
  | Break _-> Format.pp_print_string out "<break>"
  | Continue _-> Format.pp_print_string out "<continue>"
  | If(e,_,_,_)-> Format.fprintf out "if %a" Printer.pp_exp e
  | Switch(e,_,_,_)-> Format.fprintf out "switch %a" Printer.pp_exp e
  | Loop _-> Format.fprintf out "<loop>"
  | Block _-> Format.fprintf out "<block>"
  | UnspecifiedSequence _-> Format.fprintf out "<unspecified sequence>"
  | TryFinally _ | TryExcept _ | TryCatch _-> Format.fprintf out "<try>"
  | Throw _-> Format.fprintf out"<throw>"

let run () = 
  Self.result "Hello world!";
  Self.feedback ~level:2 "Writing in 'hello.out'...";
  let chan = open_out "hello.out" in 
  Printf.fprintf chan "Hello world!\n";
  close_out chan
;;

let () = Db.Main.extend run;;