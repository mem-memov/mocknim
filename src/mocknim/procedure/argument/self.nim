import 
  macros

type
  Self* = ref object
    node: NimNode

proc newSelf*(node: NimNode): Self =

  Self(
    node: node
  )