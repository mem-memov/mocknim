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


template assertArgumentValue(argument: untyped): untyped =

  echo "----------------------------------------" & $argument
  # assert(argument == expectedParameters.argument)


proc generate*(this: ArgumentAssertionTemplate): NimNode =

  getAst(
    assertArgumentValue(
      this.argumentOriginal.argumentName().ident
    )
  )