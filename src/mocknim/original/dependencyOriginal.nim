import
  macros,
  mocknim/[
    original/procedureOriginals,
    original/procedureOriginal,
    module/file
  ]
  

type
  File = file.File # disambiguate
  DependencyOriginal* = ref object
    procedureOriginals: ProcedureOriginals
    file: File


proc newDependencyOriginal*(statementsNode: NimNode, file: File): DependencyOriginal = 

  expectKind(statementsNode, nnkStmtList)

  DependencyOriginal(
    procedureOriginals: newProcedureOriginals(statementsNode),
    file: file
  )


proc getProcedures*(this: DependencyOriginal): seq[ProcedureOriginal] =

  this.procedureOriginals.create(this.file.getModuleName())


proc getModuleTypeName*(this: DependencyOriginal): string =

  this.file.getModuleName()