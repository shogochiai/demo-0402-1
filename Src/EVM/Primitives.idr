||| Minimal local EVM primitive surface for direct idris2-yul compilation.
module EVM.Primitives

%foreign "evm:sload"
export prim__sload : Integer -> PrimIO Integer

%foreign "evm:mstore"
export prim__mstore : Integer -> Integer -> PrimIO ()

%foreign "evm:calldataload"
export prim__calldataload : Integer -> PrimIO Integer

%foreign "evm:calldatasize"
export prim__calldatasize : PrimIO Integer

%foreign "evm:address"
export prim__address : PrimIO Integer

%foreign "evm:keccak256"
export prim__keccak256 : Integer -> Integer -> PrimIO Integer

%foreign "evm:return"
export prim__return : Integer -> Integer -> PrimIO ()

%foreign "evm:revert"
export prim__revert : Integer -> Integer -> PrimIO ()

export
sload : Integer -> IO Integer
sload slot = primIO (prim__sload slot)

export
mstore : Integer -> Integer -> IO ()
mstore off val = primIO (prim__mstore off val)

export
calldataload : Integer -> IO Integer
calldataload off = primIO (prim__calldataload off)

export
calldatasize : IO Integer
calldatasize = primIO prim__calldatasize

export
address : IO Integer
address = primIO prim__address

export
keccak256 : Integer -> Integer -> IO Integer
keccak256 off len = primIO (prim__keccak256 off len)

export
evmReturn : Integer -> Integer -> IO ()
evmReturn off len = primIO (prim__return off len)

export
evmRevert : Integer -> Integer -> IO ()
evmRevert off len = primIO (prim__revert off len)

export
getSelector : IO Integer
getSelector = do
  data_ <- calldataload 0
  pure (data_ `div` 0x100000000000000000000000000000000000000000000000000000000)

export
returnUint : Integer -> IO ()
returnUint val = do
  mstore 0 val
  evmReturn 0 32
