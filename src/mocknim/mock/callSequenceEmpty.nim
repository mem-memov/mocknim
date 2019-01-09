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


proc assignEmptySequence(procedureName: string): NimNode = 

  var mock = "mock".ident()
  var procedure = procedureName.ident()

  result = quote:

    `mock`.expects.`procedure` = @[]


proc generate*(this: CallSequenceEmpty): NimNode =

  result = newStmtList()

  for procedureOriginal in this.dependencyOriginal.getProcedures():

    let procedureName = procedureOriginal.getSignature().getProcedureName()
    let statements = assignEmptySequence(procedureName)

    result.add(statements)

    # echo result.repr()
