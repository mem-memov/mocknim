import 
  macros


type
  ArgumentOriginal* = ref object
    identDefsNode: NimNode


proc newArgumentOriginal*(identDefsNode: NimNode): ArgumentOriginal =

  expectKind(identDefsNode, nnkIdentDefs)

  ArgumentOriginal(
    identDefsNode: identDefsNode
  )


proc argumentName*(this: ArgumentOriginal): string =

  this.identDefsNode[0].repr()


proc typeNameNode*(this: ArgumentOriginal): NimNode =

  let typeNode = this.identDefsNode[1]

  case typeNode.kind
  of nnkIdent:
    result = typeNode
  of nnkBracketExpr:
    result = typeNode
  of nnkVarTy:
    result = typeNode[0]
  else:
    raise newException(Exception, "unknown ardument node type: " & $typeNode.kind)
