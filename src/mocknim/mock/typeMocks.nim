import 
  macros,
  mocknim/[
    original/procedureOriginal,
    original/argumentOriginal
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

  var moduleTypeFields = newTree(nnkRecList)

  for argumentOriginal in this.procedureOriginal.arguments():
    moduleTypeFields.add(
      newTree(nnkIdentDefs, 
        newIdentNode(argumentOriginal.argumentName()),
        newIdentNode(argumentOriginal.typeName()),
        newEmptyNode()
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
          moduleTypeFields
        )
      )
    )
  )

  result = newTree(nnkTypeSection, definitions)