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

  result = this.procDefNode.copyNimTree

  echo result.treeRepr()