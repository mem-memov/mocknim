import 
  macros,
  mocknim/[
    original/procedureOriginal
  ]


type
  TypeMocks* = ref object
    procedureOriginal: ProcedureOriginal


proc newTypeMocks*(procedureOriginal: ProcedureOriginal): TypeMocks =

  TypeMocks(
    procedureOriginal: procedureOriginal
  )


proc generate*(this: TypeMocks): seq[NimNode] =

  let typeNames = this.procedureOriginal.allTypeNames()
  @[newEmptyNode()]