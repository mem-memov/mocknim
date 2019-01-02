import
  macros,
  mocknim/[
    original/moduleOriginal,
    original/procedureOriginal,
    mock/procedureMock
  ]

type
  ModuleMock* = ref object
    moduleOriginal: ModuleOriginal


proc newModuleMock*(moduleOriginal: ModuleOriginal): ModuleMock = 

  ModuleMock(
    moduleOriginal: moduleOriginal
  )


proc generate*(this: ModuleMock): NimNode = 

  # let procedureOriginals = this.moduleOriginal.procedures()

  # for procedureOriginal in procedureOriginals:

  #   let procedureMock = newProcedureMock(
  #     procedureOriginal.signature(), 
  #     procedureOriginal.result(),
  #     procedureOriginal.arguments(),
  #     procedureOriginal.self()
  #   )

  newStmtList()