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
    moduleTypeName: string
    procedureName: string


proc newArgumentAssertionTemplate*(
  argumentOriginal: ArgumentOriginal,
  selfOriginal: SelfOriginal,
  moduleTypeName: string,
  procedureName: string): ArgumentAssertionTemplate =

  ArgumentAssertionTemplate(
    argumentOriginal: argumentOriginal,
    selfOriginal: selfOriginal,
    moduleTypeName: moduleTypeName,
    procedureName: procedureName
  )


proc assertArgumentValue(argumentName: string, argumentIndexInSignature: int, moduleName: string, procedureName: string): NimNode =

  var argument = argumentName.ident()
  var argumentIndex = argumentIndexInSignature.newIntLitNode()
  var expectedParameters = "expectedParameters".ident()
  let argumentString = argument.toStrLit()

  result = quote:

    if `argument` != `expectedParameters`[`argumentIndex`]:
      echo "\nUNIT TEST: Argument '" & 
        `argumentString` & 
        "' contains an unexpected value in " & 
        `moduleName` & '.' & `procedureName` & ": \n" &
        `argument`.repr() & "\n" &
        "Expected value: " & "\n" &
        `expectedParameters`[`argumentIndex`].repr() & "\n"


proc generate*(this: ArgumentAssertionTemplate): NimNode =

  var argumentIndexInSignature = this.argumentOriginal.getArgumentIndexInSignature()

  if this.selfOriginal.exists():
    argumentIndexInSignature -= 1

  assertArgumentValue(
    this.argumentOriginal.getArgumentName(),
    argumentIndexInSignature,
    this.moduleTypeName,
    this.procedureName
  )
