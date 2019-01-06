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

  for dependencyOriginal in this.moduleOriginal.getDependencies():

    for procedureOriginal in dependencyOriginal.getProcedures():

      let procedureMock = newProcedureMock(
        procedureOriginal.getSignature(), 
        procedureOriginal.getResult(),
        procedureOriginal.getArguments(),
        procedureOriginal.getSelf()
      )

      result.add(procedureMock.generate())