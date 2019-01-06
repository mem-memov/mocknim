import 
  macros


type
  ResultOriginal* = ref object
    formalParamsNode: NimNode


proc newResultOriginal*(formalParamsNode: NimNode): ResultOriginal = 

  expectKind(formalParamsNode, nnkFormalParams)

  ResultOriginal(
    formalParamsNode: formalParamsNode
  )


proc exists*(this: ResultOriginal): bool =

  this.formalParamsNode[0].kind != nnkEmpty


proc getTypeName*(this: ResultOriginal): string =

  let typeNode = this.formalParamsNode[0]

  case typeNode.kind
  of nnkIdent:
    result = typeNode.repr()
  of nnkBracketExpr:
    result = typeNode[1].repr()
  else:
    raise newException(Exception, "unknown argument node type: " & $typeNode.kind)

proc typeNameNode*(this: ResultOriginal): NimNode =

  let typeNode = this.formalParamsNode[0]

  result = typeNode
