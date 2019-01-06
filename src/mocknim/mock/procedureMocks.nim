import
  macros,
  mocknim/[
    mock/procedureMock,
    original/moduleOriginal,
    original/procedureOriginal,
    original/dependencyOriginal
  ]


type
  ProcedureMocks* = ref object
    moduleOriginal: ModuleOriginal


proc newProcedureMocks*(moduleOriginal: ModuleOriginal): ProcedureMocks =

  ProcedureMocks(
    moduleOriginal: moduleOriginal
  )


proc generate*(this: ProcedureMocks): seq[NimNode] =

  for dependencyOriginal in this.moduleOriginal.dependencies():

    for procedureOriginal in dependencyOriginal.getProcedures():

      let procedureMock = newProcedureMock(
        procedureOriginal.signature(), 
        procedureOriginal.result(),
        procedureOriginal.arguments(),
        procedureOriginal.self()
      )

      result.add(procedureMock.generate())