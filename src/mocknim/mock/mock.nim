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
    procedureMock: newProcedureMock()
  )


proc generate*(this: Mock): NimNode =

  newStmtList(
    this.typeMocks.generate(),
    this.procedureMock.generate()
  )
