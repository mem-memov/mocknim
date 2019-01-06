import 
  macros,
  mocknim/[
    factory,
    mock/moduleMock
  ]

macro mock*(moduleNameNode: string): untyped =

  let factory = newFactory()

  let mock = factory.makeMock(moduleNameNode)

  result = mock.generate()

  # echo result.repr()

  when defined(nimDumpM): # https://forum.nim-lang.org/t/4524
    echo result.repr()
