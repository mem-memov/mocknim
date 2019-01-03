import 
  macros


type
  TypeStubs* = ref object
    moduleOriginal: ModuleOriginal


proc newTypeStabs*(moduleOriginal: ModuleOriginal): TypeStubs =

  TypeStubs(
    moduleOriginal: moduleOriginal
  )


proc generate*(): NimNode =

  newEmptyNode()