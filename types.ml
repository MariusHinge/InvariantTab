type var = Const of int | Tab of string | Var of string ;;

type eq = { tab_a : var ; tab_b : var };;

type prop = Top | Bot | Eq of eq;; (* Treillis actuel :/ *)
type phi = { inf : prop list ; eq : prop list ; sup : prop list };;

type instr = Incr of var | Assign of var * var;;
type block = instr list;;

(* Tests *)

(* Exemple d'utilisation des types :
let c = Const(3);;
let tab = Tab("hello");;
let x = Var("x");;

let eq = {tab_a=tab;tab_b=x};;

*)