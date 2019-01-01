import
  macros


type
  ModuleOriginal* = ref object
    statementsNode: NimNode


proc newModuleOriginal*(statementsNode: NimNode): ModuleOriginal =

  ModuleOriginal(
    statementsNode: statementsNode
  )