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

  var moduleTypeFields = newTree(nnkRecList)

  let callCountField = newCallCountField(this.dependencyOriginal)

  moduleTypeFields.add(callCountField.generate())

  let moduleTypeName = this.dependencyOriginal.moduleTypeName()

  for procedureOriginal in this.dependencyOriginal.procedures():

    let procedureName = procedureOriginal.signature().procedureName()

    var arguments: seq[NimNode] = @[]

    for ai, argumentOriginal in procedureOriginal.arguments():

      let argumentName = argumentOriginal.argumentName()
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
        nnkPar.newTree(
          arguments # <---
        ),
        nnkTupleTy.newTree()
      )

    if argumentsPresent and resultPresent:

      callNode = nnkPar.newTree(
        nnkPar.newTree(
          arguments # <---
        ),
        procedureOriginal.result().typeNameNode() # <---
      )

    moduleTypeFields.add(
      nnkIdentDefs.newTree(
        newIdentNode(procedureName), # <---
        nnkBracketExpr.newTree(
          newIdentNode("seq"),
          callNode # <---
        ),
        newEmptyNode()
      )
    )

  result = newTree(nnkTypeDef,
    newIdentNode(moduleTypeName),  # <---
    newEmptyNode(),
    newTree(nnkRefTy,
      newTree(nnkObjectTy,
        newEmptyNode(),
        newEmptyNode(),
        moduleTypeFields # <---
      )
    )
  )

  # echo result.repr()

  # dumpAstGen:
  #   type
  #     Directory = ref object
  #       callCount: (newDirectory: 0)

