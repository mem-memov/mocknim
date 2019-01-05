import
  macros,
  mocknim/[
    templates/patch,
    original/argumentOriginal
  ]


type
  ArgumentAssertionTemplate* = ref object
    argumentOriginal: ArgumentOriginal

proc newArgumentAssertionTemplate*(argumentOriginal: ArgumentOriginal): ArgumentAssertionTemplate =

  ArgumentAssertionTemplate(
    argumentOriginal: argumentOriginal
  )


proc assertArgumentValue(argumentName: string): NimNode =

  var argument = argumentName.ident()

  result = quote:
    assert(`argument` == expectedParameters.`argument`)


proc generate*(this: ArgumentAssertionTemplate): NimNode =

  assertArgumentValue(
    this.argumentOriginal.argumentName()
  )
