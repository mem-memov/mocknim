import
  mocknim/[
    name,
    procedure/procedure,
    module/directory,
    module/module
  ]

type
  Factory = ref object

proc newFactory*(): Factory =

  Factory()


proc procedure*(this: Factory, moduleNode: NimNode, procedureNode: NimNode): Procedure =

  let moduleName = newName(moduleNode)
  let procedureName = newName(procedureNode)

  let directory = newDirectory("../src")

  let module = newModule(moduleName.toString(), directory)

  result = module.procedure(procedureName.toString())