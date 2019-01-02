import
  macros,
  mocknim/[
    original/dependencyOriginal
  ]

type
  ModuleOriginal* = ref object
    statementsNode: NimNode
    dependencyOriginals: seq[DependencyOriginal]
    name: string


proc newModuleOriginal*(statementsNode: NimNode, name: string, dependencyOriginals: seq[DependencyOriginal]): ModuleOriginal =

  expectKind(statementsNode, nnkStmtList)

  ModuleOriginal(
    statementsNode: statementsNode,
    dependencyOriginals: dependencyOriginals,
    name: name
  )


proc dependencies*(this: ModuleOriginal): seq[DependencyOriginal] =

  this.dependencyOriginals


proc copyWithoutImportStatement(this: ModuleOriginal): NimNode =

  result = this.statementsNode.copyNimTree()

  echo result.treeRepr()