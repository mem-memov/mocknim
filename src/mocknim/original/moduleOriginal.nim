import
  macros,
  mocknim/[
    original/procedureOriginals,
    original/procedureOriginal
  ]

type
  ModuleOriginal* = ref object
    procedureOriginals: ProcedureOriginals
    name: string


proc newModuleOriginal*(statementsNode: NimNode, name: string): ModuleOriginal =

  ModuleOriginal(
    procedureOriginals: newProcedureOriginals(statementsNode),
    name: name
  )


proc procedures*(this: ModuleOriginal): seq[ProcedureOriginal] =

  this.procedureOriginals.create(this.name)