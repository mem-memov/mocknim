import
  macros,
  mocknim/[
    original/moduleOriginal
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

  result = newStmtList(
    statementNodes
  )

  # echo result.repr()