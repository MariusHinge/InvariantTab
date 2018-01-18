(* open Types;; *)
(* Treillis - TODO un treillis complet qui fonctionne*)
let rec reduction_prop_list phi = 
  match phi with
  | [] -> []
  | Top::_ -> [Top] (* Vérifier, j'ai toujours un doute... *)
  | Eq(a)::q -> Eq(a)::(reduction_prop_list q)
  | Bot::q -> reduction_prop_list q
;;

let union_prop_list a b = 
  reduction_prop_list (a@b)
;;

let diff_prop p1 p2 = 
  match (p1,p2) with
  | (Top,Top) -> true
  | (Eq(x),Eq(y)) -> (x.tab_a = y.tab_a) && (x.tab_b = y.tab_b) (* = simple est important ici*)
  | (Bot,Bot) -> true
  | (_,_) -> false
;;

let rec equal_prop_list a b = 
  match (a,b) with
  | ([],[]) -> true
  | ([],_) -> false
  | (_,[]) -> false
  | (t1::q1,t2::q2) -> (equal_prop_list q1 q2) && (diff_prop t1 t2)
;; (* Ne suporte pas les permutations de listes... *)


(* Sémantique *)
let equal_phi phi_1 phi_2 = 
  (equal_prop_list phi_1.inf phi_2.inf) && (equal_prop_list phi_1.eq phi_2.eq) && (equal_prop_list phi_1.sup phi_2.sup)
;;

let union_phi phi_1 phi_2 = 
  {inf = union_prop_list phi_1.inf phi_2.inf
  ;eq = union_prop_list phi_1.eq phi_2.eq
  ;sup = union_prop_list phi_1.eq phi_2.eq}
;;

let appliq_instr phi instr = 
  match instr with
  | Incr(c) -> phi
  | Assign(x,y) -> {inf = phi.inf;
                    eq = (reduction_prop_list (Eq({tab_a=x;tab_b=y})::phi.eq)) ;
                    sup = phi.sup }
;;

let analyse_boucle block phi = 
  List.fold_left (appliq_instr) phi block 
;;

let rec looper block phi_1 phi_2 =  
  if not (equal_phi phi_1 phi_2) then let phi = (union_phi phi_1 phi_2) in looper block (analyse_boucle block phi) phi
  else phi_1
;;
