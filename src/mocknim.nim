import 
  macros,
  mocknim/[
    factory,
    mock/moduleMock
  ]

macro mock*(moduleNode: string): untyped =

  let factory = newFactory()

  let mock = factory.mock(moduleNode)

  result = mock.generate()





