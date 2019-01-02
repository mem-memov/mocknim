import
  macros,
  mocknim/[
    original/dependencyOriginal
  ]


type
  DependencyTypeMock* = ref object
    dependencyOriginal: DependencyOriginal


proc newDependencyTypeMock*(dependencyOriginal: DependencyOriginal): DependencyTypeMock =

  DependencyTypeMock(
    dependencyOriginal: dependencyOriginal
  )


proc generate*(this: DependencyTypeMock): NimNode =

  var moduleTypeFields = newTree(nnkRecList)

  # for argumentOriginal in this.procedureOriginal.arguments():
  #   moduleTypeFields.add(
  #     newTree(nnkIdentDefs, 
  #       newIdentNode(argumentOriginal.argumentName()),
  #       newIdentNode(argumentOriginal.typeName()),
  #       newEmptyNode()
  #     )
  #   )

  # var resultOriginal = this.procedureOriginal.result()

  # if resultOriginal.exists():
  #   moduleTypeFields.add(
  #     newTree(nnkIdentDefs, 
  #       newIdentNode("result"),
  #       newIdentNode(resultOriginal.typeName()),
  #       newEmptyNode()
  #     )
  #   )

  result = newTree(nnkTypeDef,
    newIdentNode(this.dependencyOriginal.moduleTypeName()),
    newEmptyNode(),
    newTree(nnkRefTy,
      newTree(nnkObjectTy,
        newEmptyNode(),
        newEmptyNode(),
        moduleTypeFields
      )
    )
  )