import
  macros,
  mocknim/[
    original/procedureOriginals,
    original/procedureOriginal
  ]

type
  ModuleOriginal* = ref object
    procedureOriginals: ProcedureOriginals


proc newModuleOriginal*(statementsNode: NimNode): ModuleOriginal =

  ModuleOriginal(
    procedureOriginals: newProcedureOriginals(statementsNode)
  )


proc procedures*(this: ModuleOriginal): seq[ProcedureOriginal] =

  this.procedureOriginals.create()