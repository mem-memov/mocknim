import
  mocknim/[
    name,
    module/module,
    module/directory,
    mock/moduleMock
  ]

type
  Factory = ref object

proc newFactory*(): Factory =

  Factory()


proc makeMock*(this: Factory, moduleNode: NimNode): ModuleMock =

  let moduleName = newName(moduleNode)

  let directory = newDirectory("../src")

  let module = newModule(
    moduleName.toString(), 
    directory
  )

  newModuleMock(module.getOriginal())