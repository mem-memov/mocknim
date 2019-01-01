import 
  macros,
  sequtils


type
  TypeOriginals* = ref object
    formalParamsNode: NimNode


proc newTypeOriginals*(formalParamsNode: NimNode): TypeOriginals =

  expectKind(formalParamsNode, nnkFormalParams)

  TypeOriginals(
    formalParamsNode: formalParamsNode
  )


proc collectTypeNames*(this: TypeOriginals): seq[string] =

  result = @[]

  for i, node in this.formalParamsNode:

    if node.kind == nnkIdent:
      let typeName = node.repr()
      result.add(typeName)

    if node.kind == nnkIdentDefs:
      let typeName = node[1].repr()
      result.add(typeName)

  result = result.deduplicate()

  echo result.repr()