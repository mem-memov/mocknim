import
  macros


type
  ProcedureMock* = ref object


proc newProcedureMock*(): ProcedureMock = 

  ProcedureMock()


proc generate*(this: ProcedureMock): NimNode =

  newEmptyNode()