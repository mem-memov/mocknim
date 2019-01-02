import
  macros,
  mocknim/[
    original/procedureOriginals,
    original/procedureOriginal,
    original/dependencyOriginals
  ]

type
  ModuleOriginal* = ref object
    procedureOriginals: ProcedureOriginals
    name: string


proc newModuleOriginal*(statementsNode: NimNode, name: string, dependencyOriginals: DependencyOriginals): ModuleOriginal =

  ModuleOriginal(
    procedureOriginals: newProcedureOriginals(statementsNode),
    name: name
  )


proc procedures*(this: ModuleOriginal): seq[ProcedureOriginal] =

  this.procedureOriginals.create(this.name)