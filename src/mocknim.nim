import 
  macros,
  mocknim/[
    factory,
    mock/mock
  ]

macro mock*(moduleNode: string, procedureNode: string): untyped =

  let factory = newFactory()

  let mock = factory.mock(moduleNode, procedureNode)

  result = mock.generate()





