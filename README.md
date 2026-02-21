# idb

IndexedDB key-value storage. Keys are safe text (validated at compile time);
values are byte arrays passed via borrow. All mutating operations return a
promise that resolves when the transaction completes.

## API

```
#use wasm.bats-packages.dev/idb as IDB
#use array as A
#use promise as P

(* Store a value.
   Resolves with an integer status (0 = success). *)
$IDB.put{n:nat}{lb:agz}{nv:nat}
  (key: A.text(n), key_len: int n,
   val: !A.borrow(byte, lb, nv), val_len: int nv)
  : promise(int, Pending)

(* Retrieve a value by key.
   Resolves with the byte length of the result; 0 means not found.
   After resolution, call get_result to fetch the bytes. *)
$IDB.get{n:nat}
  (key: A.text(n), key_len: int n)
  : promise(int, Pending)

(* Fetch the result buffer after a successful get.
   Must be called exactly once after get resolves with len > 0. *)
$IDB.get_result{len:pos}(len: int len) : [l:agz] A.arr(byte, l, len)

(* Delete a key.
   Resolves with an integer status (0 = success). *)
$IDB.delete{n:nat}
  (key: A.text(n), key_len: int n)
  : promise(int, Pending)
```

## Dependencies

- **array**
- **promise**
