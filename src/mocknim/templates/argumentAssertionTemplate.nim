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


template assertArgumentValue(): untyped =

    assert(argument == expectedParameters.argument)


proc generate*(this: ArgumentAssertionTemplate): NimNode =

  newEmptyNode()