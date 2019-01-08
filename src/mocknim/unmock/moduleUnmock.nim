import
  macros,
  mocknim/[
    original/moduleOriginal,
    unmock/constructorUnmocks
  ]

type
  ModuleUnmock* = ref object
    moduleOriginal: ModuleOriginal


proc newModuleUnmock*(moduleOriginal: ModuleOriginal): ModuleUnmock = 

  ModuleUnmock(
    moduleOriginal: moduleOriginal
  )


proc generate*(this: ModuleUnmock): NimNode = 

  var statementNodes: seq[NimNode] = @[]

  let constructorUnmocks = newConstructorUnmocks(this.moduleOriginal.getDependencies())

  for constructorResetCall in constructorUnmocks.generate():
    statementNodes.add(constructorResetCall)

  result = newStmtList(
    statementNodes
  )

  # echo result.repr()