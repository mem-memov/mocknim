import 
  macros

type
  Finalizer* = ref object


proc newFinalizer*(): Finalizer =

  Finalizer()


proc generate*(): NimNode =

  newEmptyNode()



