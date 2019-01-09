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

proc assignZeroToCount(procedureName: string): NimNode = 

  var mock = "mock".ident()
  var procedure = procedureName.ident()

  result = quote:

    `mock`.callCount.`procedure` = 0


proc generate*(this: CallCountZero): NimNode =

  result = newStmtList()

  for procedureOriginal in this.dependencyOriginal.getProcedures():

    let procedureName = procedureOriginal.getSignature().getProcedureName()
    let statements = assignZeroToCount(procedureName)

    result.add(statements)

    # echo result.repr()

