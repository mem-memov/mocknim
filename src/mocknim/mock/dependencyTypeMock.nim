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

  let moduleTypeName = this.dependencyOriginal.moduleTypeName()

  for procedureOriginal in this.dependencyOriginal.procedures():

    if procedureOriginal.isInvisible():
      continue

    var arguments: seq[NimNode] = @[]

    for ai, argumentOriginal in procedureOriginal.arguments():

      let argumentName = argumentOriginal.argumentName()
      let typeNameNode = argumentOriginal.typeNameNode()

      if moduleTypeName == typeNameNode.repr() and ai == 0: # skip "this" argument
        continue

      arguments.add(
        nnkIdentDefs.newTree(
          newIdentNode(argumentName),
          typeNameNode,
          newEmptyNode()
        )
      )

    if arguments.len() > 0:
      moduleTypeFields.add(
        nnkIdentDefs.newTree(
          newIdentNode(procedureOriginal.signature().procedureName()),
          nnkTupleTy.newTree(
            arguments
          ),
          newEmptyNode()
        )
      )

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

  echo result.repr()

  # dumpAstGen:
  #   type
  #     Directory = ref object
  #       file: tuple[name: string, foo: string]