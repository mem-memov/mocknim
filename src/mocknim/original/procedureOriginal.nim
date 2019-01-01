import 
  macros,
  sequtils,
  strutils,
  mocknim/[
    original/typeOriginals,
    original/argumentOriginal,
    original/argumentOriginals,
    original/resultOriginal,
    original/signatureOriginal
  ]


type
  ProcedureOriginal* = ref object
    typeOriginals: TypeOriginals
    argumentOriginals: ArgumentOriginals
    resultOriginal: ResultOriginal
    signatureOriginal: SignatureOriginal


proc newProcedureOriginal*(procDefNode: NimNode, moduleName: string): ProcedureOriginal =

  expectKind(procDefNode, nnkProcDef)

  # echo procDefNode.treeRepr()

  let nameParts = moduleName.split("/")
  let moduleTypeName = capitalizeAscii(nameParts[nameParts.high])

  let formalParamsNode = procDefNode[3]

  ProcedureOriginal(
    typeOriginals: newTypeOriginals(formalParamsNode, moduleTypeName),
    argumentOriginals: newArgumentOriginals(formalParamsNode),
    resultOriginal: newResultOriginal(formalParamsNode),
    signatureOriginal: newSignatureOriginal(procDefNode)
  )


proc allTypeNames*(this: ProcedureOriginal): seq[string] = 

  this.typeOriginals.collectTypeNames()


proc moduleTypeName*(this: ProcedureOriginal): string = 

  this.typeOriginals.moduleTypeName()


proc arguments*(this: ProcedureOriginal): seq[ArgumentOriginal] =

  this.argumentOriginals.create()


proc result*(this: ProcedureOriginal): ResultOriginal =

  this.resultOriginal


proc signature*(this: ProcedureOriginal): SignatureOriginal =

  this.signatureOriginal
