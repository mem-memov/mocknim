import
  macros


type
  SignatureOriginal* = ref object
    procDefNode: NimNode


proc newSignatureOriginal*(procDefNode: NimNode): SignatureOriginal =

  expectKind(procDefNode, nnkProcDef)

  SignatureOriginal(
    procDefNode: procDefNode
  )


proc copy*(this: SignatureOriginal): NimNode =

  result = this.procDefNode.copyNimTree()
  result[6] = newStmtList()

proc procedureName*(this: SignatureOriginal): string =

    let nameNode = this.procDefNode[0]

    if nameNode.kind == nnkIdent:
      result = nameNode.repr()

    if nameNode.kind == nnkPostfix:
      result = nameNode[1].repr()