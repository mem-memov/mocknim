import
  macros

type
  CallSequence* = ref object


proc newCallSequence*(): CallSequence = 

  CallSequence()


proc generate*(): NimNode =

  newEmptyNode()