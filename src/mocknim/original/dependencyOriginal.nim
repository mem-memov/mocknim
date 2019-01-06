import
  macros,
  mocknim/[
    original/procedureOriginals,
    original/procedureOriginal
  ]
  

type
  DependencyOriginal* = ref object
    procedureOriginals: ProcedureOriginals
    name: string


proc newDependencyOriginal*(statementsNode: NimNode, name: string): DependencyOriginal = 

  expectKind(statementsNode, nnkStmtList)

  DependencyOriginal(
    procedureOriginals: newProcedureOriginals(statementsNode),
    name: name
  )


proc getProcedures*(this: DependencyOriginal): seq[ProcedureOriginal] =

  this.procedureOriginals.create(this.name)


proc moduleTypeName*(this: DependencyOriginal): string =

  this.name