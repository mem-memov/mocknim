import
  macros,
  mocknim/[
    original/moduleOriginal,
    mock/procedureMock,
    mock/dependencyTypeMocks,
    mock/procedureMocks,
    mock/constructorMocks
  ]

type
  ModuleMock* = ref object
    moduleOriginal: ModuleOriginal


proc newModuleMock*(moduleOriginal: ModuleOriginal): ModuleMock = 

  ModuleMock(
    moduleOriginal: moduleOriginal
  )


proc generate*(this: ModuleMock): NimNode = 

  var statementNodes: seq[NimNode] = @[]

  let dependencyTypeMocks = newDependencyTypeMocks(
    this.moduleOriginal.dependencies()
  )

  statementNodes.add(dependencyTypeMocks.generate())

  let procedureMocks = newProcedureMocks(this.moduleOriginal)

  for procedureDefinition in procedureMocks.generate():
    statementNodes.add(procedureDefinition)

  statementNodes.add(
    this.moduleOriginal.copyWithoutImportStatement()
  )

  let constructorMocks = newConstructorMocks(this.moduleOriginal.dependencies())

  for constructorDefinition in constructorMocks.generate:
    statementNodes.add(constructorDefinition)

  result = newStmtList(
    statementNodes
  )

  echo result.repr()