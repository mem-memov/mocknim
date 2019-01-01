import 
  macros


type
  ResultOriginal* = ref object
    formalParamsNode: NimNode


proc newResultOriginal(formalParamsNode: NimNode): ResultOriginal = 

  expectKind(formalParamsNode, nnkFormalParams)

  ResultOriginal(
    formalParamsNode: formalParamsNode
  )


proc exists*(this: ResultOriginal): bool =

  formalParamsNode[0].kind != nnkEmpty


proc typeName*(this: ResultOriginal): string =

  formalParamsNode[0].repr()