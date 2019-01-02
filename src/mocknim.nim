import 
  macros #,
  # mocknim/[
  #   factory,
  #   mock/moduleMock
  # ]

macro mock*(moduleNameNodes: varargs[typed]): untyped =

  result = newStmtList()

  for name in moduleNameNodes:
    echo name.repr
  

  # let factory = newFactory()

  # let mock = factory.mock(moduleNode)

  # result = mock.generate()





