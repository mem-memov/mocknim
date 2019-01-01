import 
  macros,
  strutils

type
  Name* = ref object
    node: NimNode

proc newName*(node: NimNode): Name =

  Name(
    node: node
  )

proc toString*(this: Name): string =

  this.node.repr().strip(true, true, {'"'})