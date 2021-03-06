import
  macros,
  mocknim/[
    original/moduleOriginal,
    mock/procedureMock,
    mock/dependencyTypeMocks,
    mock/procedureMocks,
    mock/constructorMocks,
    mock/destructorMocks,
    mock/typeStubs
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

  let typeStubs = newTypeStabs(this.moduleOriginal)

  statementNodes.add(typeStubs.generate())

  let dependencyTypeMocks = newDependencyTypeMocks(
    this.moduleOriginal.getDependencies()
  )

  statementNodes.add(dependencyTypeMocks.generate())

  let constructorMocks = newConstructorMocks(this.moduleOriginal.getDependencies())

  for constructorDefinition in constructorMocks.generate():
    statementNodes.add(constructorDefinition)

  let destructorMocks = newDestructorMocks(this.moduleOriginal.getDependencies())

  for destructorDefinition in destructorMocks.generate():
    statementNodes.add(destructorDefinition)

  let procedureMocks = newProcedureMocks(this.moduleOriginal)

  for procedureDefinition in procedureMocks.generate():
    statementNodes.add(procedureDefinition)

  statementNodes.add(
    this.moduleOriginal.copyWithoutImportStatement()
  )

  result = newStmtList(
    statementNodes
  )

  # echo result.repr()