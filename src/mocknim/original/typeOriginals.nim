import 
  macros,
  sequtils,
  strutils    


type
  TypeOriginals* = ref object
    formalParamsNode: NimNode
    moduleTypeName: string


proc newTypeOriginals*(formalParamsNode: NimNode, moduleTypeName: string): TypeOriginals =

  expectKind(formalParamsNode, nnkFormalParams)

  TypeOriginals(
    formalParamsNode: formalParamsNode,
    moduleTypeName: moduleTypeName
  )


proc collectTypeNames*(this: TypeOriginals): seq[string] =

  result = @[]

  for i, node in this.formalParamsNode:

    if node.kind == nnkIdent:
      let typeName = node.repr()
      if isUpperAscii(typeName[0]) and typeName != this.moduleTypeName:
        result.add(typeName)

    if node.kind == nnkIdentDefs:
      let typeName = node[1].repr()
      if isUpperAscii(typeName[0]) and typeName != this.moduleTypeName:
        result.add(typeName)

  result = result.deduplicate()
