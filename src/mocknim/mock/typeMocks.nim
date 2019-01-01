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


proc generate*(this: TypeMocks): NimNode =

  var definitions: seq[NimNode] = @[]

  for typeName in this.procedureOriginal.allTypeNames():
    definitions.add(
      newTree(nnkTypeDef,
        newIdentNode(typeName),
        newEmptyNode(),
        newTree(nnkRefTy,
          newTree(nnkObjectTy,
            newEmptyNode(),
            newEmptyNode(),
            newEmptyNode()
          )
        )
      )
    )

  definitions.add(
    newTree(nnkTypeDef,
      newIdentNode(this.procedureOriginal.moduleTypeName()),
      newEmptyNode(),
      newTree(nnkRefTy,
        newTree(nnkObjectTy,
          newEmptyNode(),
          newEmptyNode(),
          newEmptyNode()
        )
      )
    )
  )

  result = newTree(nnkTypeSection, definitions)