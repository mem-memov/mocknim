import
  macros,
  mocknim/[
    original/dependencyOriginal,
    original/procedureOriginal,
    original/signatureOriginal,
    original/argumentOriginal
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

  for procedureOriginal in this.dependencyOriginal.procedures():

    var arguments: seq[NimNode] = @[]

    # for argumentOriginal in procedureOriginal.arguments():

    #   arguments.add(
    #     nnkExprColonExpr.newTree(
    #       newIdentNode(argumentOriginal.argumentName()),
    #       newIdentNode(argumentOriginal.typeName())
    #     )
    #   )

    # moduleTypeFields.add(
    #   nnkIdentDefs.newTree(
    #     newIdentNode(procedureOriginal.signature().procedureName()),
    #     nnkPar.newTree(
    #       arguments
    #     ),
    #     newEmptyNode()
    #   )
    # )

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

  # echo result.repr()

  # dumpAstGen:
  #   type
  #     Directory = ref object
  #       file: (name: string, foo: string)