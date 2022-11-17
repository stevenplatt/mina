open Mina_base

let `VK {With_hash.data= vk; hash= _}, `Prover p =
  Transaction_snark.For_tests.create_trivial_snapp
    ~constraint_constants:Genesis_constants.Constraint_constants.compiled ()

let vk = Pickles.Side_loaded.Verification_key.For_tests.forget_wrap_vk vk

let stmt : Zkapp_statement.t =
  { Zkapp_statement.Poly.account_update = Snark_params.Tick.Field.one
  ; calls = Snark_params.Tick.Field.one
  }

let (), (), proof = Async.Thread_safe.block_on_async_exn (fun () -> p stmt)

let proof = Pickles.Side_loaded.Proof.of_proof proof

let to_verify = [ (vk, stmt, proof) ]

let verify () = Pickles.Side_loaded.verify ~typ:Zkapp_statement.typ to_verify

let%test "Verifies" = Async.Thread_safe.block_on_async_exn (fun () -> verify ())
