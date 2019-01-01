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

proc newMock*(procedure: ProcedureOriginal): Mock = 

  Mock(
    typeMocks: newTypeMocks(),
    procedureMock: newProcedureMock()
  )

proc generate*(this: Mock): NimNode =

  result = newStmtList()

  for typeMock in this.typeMocks.generate():
    result.add(typeMock)

  result.add(this.procedureMock.generate())
