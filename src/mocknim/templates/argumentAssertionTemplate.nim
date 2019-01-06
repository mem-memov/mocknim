import
  macros,
  mocknim/[
    original/argumentOriginal,
    original/selfOriginal
  ]


type
  ArgumentAssertionTemplate* = ref object
    argumentOriginal: ArgumentOriginal
    selfOriginal: SelfOriginal


proc newArgumentAssertionTemplate*(
  argumentOriginal: ArgumentOriginal,
  selfOriginal: SelfOriginal): ArgumentAssertionTemplate =

  ArgumentAssertionTemplate(
    argumentOriginal: argumentOriginal,
    selfOriginal: selfOriginal
  )


proc assertArgumentValue(argumentName: string, argumentIndexInSignature: int): NimNode =

  var argument = argumentName.ident()
  var argumentIndex = argumentIndexInSignature.newIntLitNode()
  var expectedParameters = "expectedParameters".ident()
  let argumentString = argument.toStrLit()

  result = quote:

    assert(
      `argument` == `expectedParameters`[`argumentIndex`],
      "UNIT TEST: Argument " & 
      `argumentString` & 
      " contains an unexpected value '" & 
      $`expectedParameters`[`argumentIndex`] & 
      "' insdead of '" &
      $`argument` &
      "'"
    )


proc generate*(this: ArgumentAssertionTemplate): NimNode =

  var argumentIndexInSignature = this.argumentOriginal.argumentIndexInSignature()

  if this.selfOriginal.exists():
    argumentIndexInSignature -= 1

  assertArgumentValue(
    this.argumentOriginal.getArgumentName(),
    argumentIndexInSignature
  )
