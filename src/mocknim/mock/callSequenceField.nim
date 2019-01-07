import
  macros,
  mocknim/[
    original/dependencyOriginal,
    original/procedureOriginal,
    original/signatureOriginal,
    original/argumentOriginal,
    original/resultOriginal
  ]

type
  CallSequenceField* = ref object
    dependencyOriginal: DependencyOriginal


proc newCallSequenceField*(dependencyOriginal: DependencyOriginal): CallSequenceField = 

  CallSequenceField(
    dependencyOriginal: dependencyOriginal
  )


proc generate*(this: CallSequenceField): NimNode =

  let moduleTypeName = this.dependencyOriginal.getModuleTypeName()

  let moduleCallFields = nnkTupleTy.newTree()

  for procedureOriginal in this.dependencyOriginal.getProcedures():

    let procedureName = procedureOriginal.getSignature().getProcedureName()

    var arguments: seq[NimNode] = @[]

    for ai, argumentOriginal in procedureOriginal.getArguments():

      let argumentName = argumentOriginal.getArgumentName()
      let typeNameNode = argumentOriginal.getTypeNameNode()

      if moduleTypeName == typeNameNode.repr() and ai == 0: # skip "this" argument
        continue

      arguments.add(
        typeNameNode
      )

    let argumentsPresent = arguments.len() > 0
    let resultPresent = procedureOriginal.getResult().exists()
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
        procedureOriginal.getResult().getTypeNameNode() # <---
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
        procedureOriginal.getResult().getTypeNameNode() # <---
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

  result = nnkIdentDefs.newTree(
    newIdentNode("expects"),
    moduleCallFields,
    newEmptyNode()
  )