import 
  macros


type
  ArgumentOriginal* = ref object
    indexInSignature: int
    identDefsNode: NimNode


proc newArgumentOriginal*(indexInSignature: int, identDefsNode: NimNode): ArgumentOriginal =

  expectKind(identDefsNode, nnkIdentDefs)

  ArgumentOriginal(
    indexInSignature: indexInSignature,
    identDefsNode: identDefsNode
  )


proc getArgumentName*(this: ArgumentOriginal): string =

  this.identDefsNode[0].repr()


proc getArgumentIndexInSignature*(this: ArgumentOriginal): int =

  this.indexInSignature


proc getTypeNameNode*(this: ArgumentOriginal): NimNode =

  let typeNode = this.identDefsNode[1]

  case typeNode.kind
  of nnkIdent:
    result = typeNode
  of nnkBracketExpr:
    result = typeNode
  of nnkVarTy:
    result = typeNode[0]
  else:
    raise newException(Exception, "unknown argument node type: " & $typeNode.kind)
