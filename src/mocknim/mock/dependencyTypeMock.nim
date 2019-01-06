import
  macros,
  mocknim/[
    original/dependencyOriginal,
    original/procedureOriginal,
    original/signatureOriginal,
    original/argumentOriginal,
    original/resultOriginal,
    mock/callCountField
  ]


type
  DependencyTypeMock* = ref object
    dependencyOriginal: DependencyOriginal


proc newDependencyTypeMock*(dependencyOriginal: DependencyOriginal): DependencyTypeMock =

  DependencyTypeMock(
    dependencyOriginal: dependencyOriginal
  )


proc generate*(this: DependencyTypeMock): NimNode =

  var moduleTypeFields = nnkRecList.newTree()

  let callCountField = newCallCountField(this.dependencyOriginal)

  moduleTypeFields.add(callCountField.generate())

  let moduleTypeName = this.dependencyOriginal.moduleTypeName()

  let moduleCallFields = nnkTupleTy.newTree()

  for procedureOriginal in this.dependencyOriginal.procedures():

    let procedureName = procedureOriginal.signature().procedureName()

    var arguments: seq[NimNode] = @[]

    for ai, argumentOriginal in procedureOriginal.arguments():

      let argumentName = argumentOriginal.getArgumentName()
      let typeNameNode = argumentOriginal.typeNameNode()

      if moduleTypeName == typeNameNode.repr() and ai == 0: # skip "this" argument
        continue

      arguments.add(
        typeNameNode
      )

    let argumentsPresent = arguments.len() > 0
    let resultPresent = procedureOriginal.result().exists()
    var callNode: NimNode;

    if not argumentsPresent and not resultPresent:

      callNode = nnkPar.newTree(
        nnkPar.newTree(
          nnkTupleTy.newTree(),
          nnkTupleTy.newTree()
        )
      )

    if not argumentsPresent and resultPresent:

      callNode = nnkPar.newTree(
        nnkTupleTy.newTree(),
        procedureOriginal.result().typeNameNode() # <---
      )

    if argumentsPresent and not resultPresent:

      callNode = nnkPar.newTree(
        nnkTupleConstr.newTree(
          arguments # <---
        ),
        nnkTupleTy.newTree()
      )

    if argumentsPresent and resultPresent:

      callNode = nnkPar.newTree(
        nnkTupleConstr.newTree(
          arguments # <---
        ),
        procedureOriginal.result().typeNameNode() # <---
      )

    moduleCallFields.add(
      nnkIdentDefs.newTree(
        newIdentNode(procedureName), # <---
        nnkBracketExpr.newTree(
          newIdentNode("seq"),
          callNode # <---
        ),
        newEmptyNode()
      )
    )

  moduleTypeFields.add(
    nnkIdentDefs.newTree(
      newIdentNode("expects"),
      moduleCallFields,
      newEmptyNode()
    )
  )

  result = nnkTypeDef.newTree(
    newIdentNode(moduleTypeName),  # <---
    newEmptyNode(),
    nnkRefTy.newTree(
      nnkObjectTy.newTree(
        newEmptyNode(),
        newEmptyNode(),
        moduleTypeFields, # <---
      )
    )
  )

  # echo result.repr()

  # dumpAstGen:
  #   type
  #     Directory = ref object
  #       callCount: tuple[newDirectory: int]
  #       expects: tuple[
  #         newDirectory: seq[
  #           (
  #             (string,), 
  #             File
  #           )
  #         ]
  #       ]


