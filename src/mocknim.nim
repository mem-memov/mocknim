import 
  macros,
  mocknim/[
    factory,
    mock/moduleMock
  ]

macro mock*(moduleNameNode: string): untyped =

  result = newStmtList()

  let factory = newFactory()

  let mock = factory.mock(moduleNameNode)

  result = mock.generate()





