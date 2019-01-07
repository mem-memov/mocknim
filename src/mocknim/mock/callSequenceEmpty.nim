import
  macros,
  mocknim/[
    original/dependencyOriginal,
    original/procedureOriginal,
    original/signatureOriginal
  ]

type
  CallSequenceEmpty* = ref object
    dependencyOriginal: DependencyOriginal


proc newCallSequenceEmpty*(dependencyOriginal: DependencyOriginal): CallSequenceEmpty = 

  CallSequenceEmpty(
    dependencyOriginal: dependencyOriginal
  )


proc generate*(this: CallSequenceEmpty): NimNode =

  var moduleCallFields: seq[NimNode] = @[]

  for procedureOriginal in this.dependencyOriginal.getProcedures():

    let procedureName = procedureOriginal.getSignature().getProcedureName()

    moduleCallFields.add(
      nnkExprColonExpr.newTree(
        newIdentNode(procedureName), # <---
        nnkPrefix.newTree(
          newIdentNode("@"),
          nnkBracket.newTree(
          )
        )
      )
    )

  result = nnkExprColonExpr.newTree(
    newIdentNode("expects"),
    nnkPar.newTree(
      moduleCallFields
    )
  )