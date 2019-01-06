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


proc getDependencies*(this: ModuleOriginal): seq[DependencyOriginal] =

  this.dependencyOriginals


proc copyWithoutImportStatement*(this: ModuleOriginal): NimNode =

  var copy = this.statementsNode.copyNimTree()

  copy[0] = newEmptyNode()

  # removing import statement

  let typeSectionNode = copy[1]

  # removing asterisks from type names

  for typeDefNode in typeSectionNode:

    if typeDefNode.kind == nnkTypeDef:

      if typeDefNode[0].kind == nnkPostfix:

        let typeName = $typeDefNode[0][1]

        typeDefNode[0] = newIdentNode(typeName)


  # removing asterisks from procedure names

  for procDefNode in copy:

    if procDefNode.kind == nnkProcDef:

      if procDefNode[0].kind == nnkPostfix:

        let procedureName = $procDefNode[0][1]

        procDefNode[0] = newIdentNode(procedureName)

  result = copy

