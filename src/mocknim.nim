import 
  macros,
  mocknim/[
    factory,
    mock/moduleMock,
    unmock/moduleUnmock
  ]

macro mock*(moduleNameNode: string): untyped =

  let factory = newFactory()

  let mock = factory.makeMock(moduleNameNode)

  result = mock.generate()

  # echo result.repr()

  when defined(nimDumpM): # https://forum.nim-lang.org/t/4524
    echo result.repr()


macro unmock*(moduleNameNode: string): untyped =

  let factory = newFactory()

  let unmock = factory.makeUnmock(moduleNameNode)

  result = unmock.generate()