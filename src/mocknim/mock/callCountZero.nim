import
  macros,
  mocknim/[
    original/dependencyOriginal,
    original/procedureOriginal,
    original/signatureOriginal
  ]


type 
  CallCountZero* = ref object
    dependencyOriginal: DependencyOriginal


proc newCallCountZero*(dependencyOriginal: DependencyOriginal): CallCountZero =

  CallCountZero(
    dependencyOriginal: dependencyOriginal
  )


proc generate*(this: CallCountZero): NimNode =

  var countNodes: seq[NimNode] = @[]

  for procedureOriginal in this.dependencyOriginal.getProcedures():

    countNodes.add(
      nnkExprColonExpr.newTree(
        newIdentNode(procedureOriginal.getSignature().getProcedureName()),
        newLit(0)
      )
    )

  result = nnkExprColonExpr.newTree(
    newIdentNode("callCount"),
    nnkPar.newTree(
      countNodes
    )
  )
