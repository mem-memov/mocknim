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

proc procedures*(this: DependencyOriginal): seq[ProcedureOriginal] =

  this.procedureOriginals.create(this.name)