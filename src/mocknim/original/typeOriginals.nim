import 
  macros,
  sequtils,
  strutils    


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
      if isUpperAscii(typeName[0]):
        result.add(typeName)

    if node.kind == nnkIdentDefs:
      let typeName = node[1].repr()
      if isUpperAscii(typeName[0]):
        result.add(typeName)

  result = result.deduplicate()
