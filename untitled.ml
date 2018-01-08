sig
  type 't action = Default | Done of 't | Post of ('t -> 't)
  type 't stmtaction = SDefault | SDone | SUse of 't
  type 't guardaction = GDefault | GUse of 't | GUnreachable
  module type StmtStartData =
    sig
      type data
      val clear : unit -> unit
      val mem : Cil_types.stmt -> bool
      val find : Cil_types.stmt -> Dataflow2.StmtStartData.data
      val replace : Cil_types.stmt -> Dataflow2.StmtStartData.data -> unit
      val add : Cil_types.stmt -> Dataflow2.StmtStartData.data -> unit
      val iter :
        (Cil_types.stmt -> Dataflow2.StmtStartData.data -> unit) -> unit
      val length : unit -> int
    end
  module StartData :
    functor (X : sig type t val size : int end) ->
      sig
        type data = X.t
        val clear : unit -> unit
        val mem : Cil_types.stmt -> bool
        val find : Cil_types.stmt -> data
        val replace : Cil_types.stmt -> data -> unit
        val add : Cil_types.stmt -> data -> unit
        val iter : (Cil_types.stmt -> data -> unit) -> unit
        val length : unit -> int
      end
  module type ForwardsTransfer =
    sig
      val name : string
      val debug : bool
      type t
      val copy : Dataflow2.ForwardsTransfer.t -> Dataflow2.ForwardsTransfer.t
      val pretty : Format.formatter -> Dataflow2.ForwardsTransfer.t -> unit
      val computeFirstPredecessor :
        Cil_types.stmt ->
        Dataflow2.ForwardsTransfer.t -> Dataflow2.ForwardsTransfer.t
      val combinePredecessors :
        Cil_types.stmt ->
        old:Dataflow2.ForwardsTransfer.t ->
        Dataflow2.ForwardsTransfer.t -> Dataflow2.ForwardsTransfer.t option
      val doInstr :
        Cil_types.stmt ->
        Cil_types.instr ->
        Dataflow2.ForwardsTransfer.t -> Dataflow2.ForwardsTransfer.t
      val doGuard :
        Cil_types.stmt ->
        Cil_types.exp ->
        Dataflow2.ForwardsTransfer.t ->
        Dataflow2.ForwardsTransfer.t Dataflow2.guardaction *
        Dataflow2.ForwardsTransfer.t Dataflow2.guardaction
      val doStmt :
        Cil_types.stmt ->
        Dataflow2.ForwardsTransfer.t ->
        Dataflow2.ForwardsTransfer.t Dataflow2.stmtaction
      val doEdge :
        Cil_types.stmt ->
        Cil_types.stmt ->
        Dataflow2.ForwardsTransfer.t -> Dataflow2.ForwardsTransfer.t
      module StmtStartData :
        sig
          type data = t
          val clear : unit -> unit
          val mem : Cil_types.stmt -> bool
          val find : Cil_types.stmt -> data
          val replace : Cil_types.stmt -> data -> unit
          val add : Cil_types.stmt -> data -> unit
          val iter : (Cil_types.stmt -> data -> unit) -> unit
          val length : unit -> int
        end
    end
  module Forwards :
    functor (T : ForwardsTransfer) ->
      sig
        val compute : Cil_types.stmt list -> unit
        val compute_strategy :
          Cil_types.stmt list -> Wto_statement.wto -> unit
        val compute_worklist : Cil_types.stmt list -> unit
      end
  module type BackwardsTransfer =
    sig
      val name : string
      val debug : bool
      type t
      val pretty : Format.formatter -> Dataflow2.BackwardsTransfer.t -> unit
      val funcExitData : Dataflow2.BackwardsTransfer.t
      val combineStmtStartData :
        Cil_types.stmt ->
        old:Dataflow2.BackwardsTransfer.t ->
        Dataflow2.BackwardsTransfer.t -> Dataflow2.BackwardsTransfer.t option
      val combineSuccessors :
        Dataflow2.BackwardsTransfer.t ->
        Dataflow2.BackwardsTransfer.t -> Dataflow2.BackwardsTransfer.t
      val doStmt :
        Cil_types.stmt -> Dataflow2.BackwardsTransfer.t Dataflow2.action
      val doInstr :
        Cil_types.stmt ->
        Cil_types.instr ->
        Dataflow2.BackwardsTransfer.t ->
        Dataflow2.BackwardsTransfer.t Dataflow2.action
      val filterStmt : Cil_types.stmt -> Cil_types.stmt -> bool
      module StmtStartData :
        sig
          type data = t
          val clear : unit -> unit
          val mem : Cil_types.stmt -> bool
          val find : Cil_types.stmt -> data
          val replace : Cil_types.stmt -> data -> unit
          val add : Cil_types.stmt -> data -> unit
          val iter : (Cil_types.stmt -> data -> unit) -> unit
          val length : unit -> int
        end
    end
  module Backwards :
    functor (T : BackwardsTransfer) ->
      sig val compute : Cil_types.stmt list -> unit end
  val find_stmts :
    Cil_types.fundec -> Cil_types.stmt list * Cil_types.stmt list
end