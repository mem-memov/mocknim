import 
  macros,
  sequtils,
  strutils,
  mocknim/[
    original/typeOriginals,
    original/argumentOriginal,
    original/argumentOriginals
  ]


type
  ProcedureOriginal* = ref object
    typeOriginals: TypeOriginals
    argumentOriginals: ArgumentOriginals


proc newProcedureOriginal*(procDefNode: NimNode, moduleName: string): ProcedureOriginal =

  expectKind(procDefNode, nnkProcDef)

  # echo procDefNode.treeRepr()

  let nameParts = moduleName.split("/")
  let moduleTypeName = capitalizeAscii(nameParts[nameParts.high])

  let formalParamsNode = procDefNode[3]

  ProcedureOriginal(
    typeOriginals: newTypeOriginals(formalParamsNode, moduleTypeName),
    argumentOriginals: newArgumentOriginals(formalParamsNode)
  )


proc allTypeNames*(this: ProcedureOriginal): seq[string] = 

  this.typeOriginals.collectTypeNames()


proc moduleTypeName*(this: ProcedureOriginal): string = 

  this.typeOriginals.moduleTypeName()


proc arguments*(this: ProcedureOriginal): seq[ArgumentOriginal] =

  this.argumentOriginals.create()
