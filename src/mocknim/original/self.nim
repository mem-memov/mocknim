import 
  macros,
  strutils

type
  Self* = ref object
    node: NimNode
    moduleTypeName: string

proc newSelf*(node: NimNode, moduleTypeName: string): Self =

  Self(
    node: node,
    moduleTypeName: moduleTypeName
  )


proc exists*(this: Self): bool =

  for node in this.node:

    if node.kind != nnkFormalParams:
      continue

    if node.len() < 2:
      return false

    let parameter = node[1]

    let typeName = parameter[1]

    if this.moduleTypeName == typeName.repr():
      return true

  return false