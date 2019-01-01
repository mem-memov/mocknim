import
  macros,
  mocknim/[
    original/moduleOriginal
  ]

type
  ModuleMock* = ref object
    moduleOriginal: ModuleOriginal


proc newModuleMock*(moduleOriginal: ModuleOriginal): ModuleMock = 

  ModuleMock(
    moduleOriginal: moduleOriginal
  )


proc generate*(this: ModuleMock): NimNode = 

  let procedureOriginals = this.moduleOriginal.procedures()

  newEmptyNode()