import
  mocknim/[
    name,
    module/module,
    module/directory,
    mock/mock
  ]

type
  Factory = ref object

proc newFactory*(): Factory =

  Factory()


proc mock*(this: Factory, moduleNode: NimNode, procedureNode: NimNode): Mock =

  # let moduleName = newName(moduleNode)
  # let procedureName = newName(procedureNode)

  # let directory = newDirectory("../src")

  # let module = newModule(moduleName.toString(), directory)

  # result = module.procedure(procedureName.toString())

  newMock()