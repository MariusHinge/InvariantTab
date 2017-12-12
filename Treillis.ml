(*
  Fichier de définition de notre treillis custom
*)

type state;;

(*\fn top
  \val top : state
  \details Greatest element.
*)

(*\fn is_included
  \val is_included : state -> state -> bool
  \details Inclusion test.
*)

(*\fn join
  \val join : state -> state -> state
  \details Semi-lattice structure.
*)

(*\fn widen
  \val widen : Cil_types.kernel_function -> Cil_types.stmt -> state -> state -> state
  \details widen h t1 t2 is an over-approximation of join t1 t2. Assumes is_included t1 t2
 *)


(*\fn narrow
  \val narrow : state -> state -> state Eval.or_bottom
  \details Over-approximation of the intersection of two abstract states (called meet in the literature).
  Used only to gain some precision when interpreting the complete behaviors of a function specification.
  Can be very imprecise without impeding the analysis: meet x y = `Value x is always sound.
*)