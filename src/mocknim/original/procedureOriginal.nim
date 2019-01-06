import 
  macros,
  sequtils,
  strutils,
  mocknim/[
    original/typeOriginals,
    original/argumentOriginal,
    original/argumentOriginals,
    original/resultOriginal,
    original/signatureOriginal,
    original/selfOriginal
  ]


type
  ProcedureOriginal* = ref object
    typeOriginals: TypeOriginals
    argumentOriginals: ArgumentOriginals
    resultOriginal: ResultOriginal
    signatureOriginal: SignatureOriginal
    selfOriginal: SelfOriginal


proc newProcedureOriginal*(procDefNode: NimNode, moduleName: string): ProcedureOriginal =

  expectKind(procDefNode, nnkProcDef)

  let nameParts = moduleName.split("/")
  let moduleTypeName = capitalizeAscii(nameParts[nameParts.high])

  let formalParamsNode = procDefNode[3]

  ProcedureOriginal(
    typeOriginals: newTypeOriginals(formalParamsNode, moduleTypeName),
    argumentOriginals: newArgumentOriginals(formalParamsNode),
    resultOriginal: newResultOriginal(formalParamsNode),
    signatureOriginal: newSignatureOriginal(procDefNode),
    selfOriginal: newSelfOriginal(formalParamsNode, moduleTypeName)
  )


proc getAllTypeNames*(this: ProcedureOriginal): seq[string] = 

  result = this.typeOriginals.collectTypeNames()

  if this.resultOriginal.exists():
    result.add(this.resultOriginal.typeName())


proc getArguments*(this: ProcedureOriginal): seq[ArgumentOriginal] =

  this.argumentOriginals.create()


proc getResult*(this: ProcedureOriginal): ResultOriginal =

  this.resultOriginal


proc signature*(this: ProcedureOriginal): SignatureOriginal =

  this.signatureOriginal


proc self*(this: ProcedureOriginal): SelfOriginal =

  this.selfOriginal


proc isInvisible*(this: ProcedureOriginal): bool = 

  this.signatureOriginal.isInvisible()