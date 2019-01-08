import
  macros,
  mocknim/[
    original/moduleOriginal,
    mock/procedureMock,
    mock/dependencyTypeMocks,
    mock/procedureMocks,
    mock/constructorMocks,
    mock/typeStubs,
    mock/finalizers
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

  let finalizers = newFinalizers(this.moduleOriginal.getDependencies())

  for finalizerProcedure in finalizers.generate():
    statementNodes.add(finalizerProcedure)

  let constructorMocks = newConstructorMocks(this.moduleOriginal.getDependencies())

  for constructorDefinition in constructorMocks.generate():
    statementNodes.add(constructorDefinition)

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