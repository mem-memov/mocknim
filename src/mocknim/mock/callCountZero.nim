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

  let moduleTypeName = this.dependencyOriginal.getModuleTypeName()

  var countNodes: seq[NimNode] = @[]

  for procedureOriginal in this.dependencyOriginal.getProcedures():

    countNodes.add(
      nnkExprColonExpr.newTree(
        newIdentNode(procedureOriginal.signature().procedureName()),
        newLit(0)
      )
    )

  result = nnkObjConstr.newTree(
    newIdentNode(moduleTypeName),
    nnkExprColonExpr.newTree(
      newIdentNode("callCount"),
      nnkPar.newTree(
        countNodes
      )
    )
  )