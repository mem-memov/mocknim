import
  macros,
  mocknim/[
    mock/typeMocks,
    mock/procedureMock,
    original/procedureOriginal
  ]


type
  Mock* = ref object
    typeMocks: TypeMocks
    procedureMock: ProcedureMock


proc newMock*(procedureOriginal: ProcedureOriginal): Mock = 

  Mock(
    typeMocks: newTypeMocks(procedureOriginal),
    procedureMock: newProcedureMock(
      procedureOriginal.signature(), 
      procedureOriginal.result(),
      procedureOriginal.arguments(),
      procedureOriginal.self()
    )
  )


proc generate*(this: Mock): NimNode =

  newStmtList(
    this.typeMocks.generate(),
    this.procedureMock.generate()
  )
