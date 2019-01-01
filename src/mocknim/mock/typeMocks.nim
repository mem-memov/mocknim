import 
  macros

type
  TypeMocks* = ref object


proc newTypeMocks*(): TypeMocks =

  TypeMocks()


proc generate*(this: TypeMocks): seq[NimNode] =

  @[newEmptyNode()]