import
  macros,
  mocknim/[
    module/file
  ]

type
  Imports* = ref object


proc newImports*(ast: NimNode): Imports =
 
  Imports()


proc files*(this: Imports): seq[file.File] =

  @[]