(* idb -- IndexedDB key-value storage *)

#include "share/atspre_staload.hats"

#use array as A
#use promise as P
#use wasm.bats-packages.dev/bridge as B

#pub fun put
  {lk:agz}{nk:pos}{lv:agz}{nv:nat}
  (key: !$A.borrow(byte, lk, nk), key_len: int nk,
   val_data: !$A.borrow(byte, lv, nv), val_len: int nv)
  : $P.promise(int, $P.Pending)

#pub fun get
  {lk:agz}{nk:pos}
  (key: !$A.borrow(byte, lk, nk), key_len: int nk)
  : $P.promise(int, $P.Pending)

#pub fun get_result
  {n:pos | n <= 1048576}
  (len: int n): [l:agz] $A.arr(byte, l, n)

#pub fun delete
  {lk:agz}{nk:pos}
  (key: !$A.borrow(byte, lk, nk), key_len: int nk)
  : $P.promise(int, $P.Pending)

implement put{lk}{nk}{lv}{nv}(key, key_len, val_data, val_len) = let
  val @(p, r) = $P.create<int>()
  val id = $P.stash(r)
  val () = $B.idb_put(key, key_len, val_data, val_len, id)
in p end

implement get{lk}{nk}(key, key_len) = let
  val @(p, r) = $P.create<int>()
  val id = $P.stash(r)
  val () = $B.idb_get(key, key_len, id)
in p end

implement get_result{n}(len) = $B.idb_get_result(len)

implement delete{lk}{nk}(key, key_len) = let
  val @(p, r) = $P.create<int>()
  val id = $P.stash(r)
  val () = $B.idb_delete(key, key_len, id)
in p end
