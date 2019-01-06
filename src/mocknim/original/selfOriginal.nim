import
  macros


type
  SelfOriginal* = ref object
    formalParamsNode: NimNode
    moduleTypeName: string


proc newSelfOriginal*(formalParamsNode: NimNode, moduleTypeName: string): SelfOriginal =

  expectKind(formalParamsNode, nnkFormalParams)

  SelfOriginal(
    formalParamsNode: formalParamsNode,
    moduleTypeName: moduleTypeName
  )


proc exists*(this: SelfOriginal): bool =

  if this.formalParamsNode.len < 2:
    return false

  let selfNode = this.formalParamsNode[1]

  if selfNode.kind == nnkIdentDefs:
    let selfTypeName = selfNode[1].repr()
    return selfTypeName == this.moduleTypeName


proc getModuleTypeName*(this: SelfOriginal): string =

  this.moduleTypeName


proc getParameterName*(this: SelfOriginal): string =

  let selfNode = this.formalParamsNode[1]

  result = selfNode[0].repr()