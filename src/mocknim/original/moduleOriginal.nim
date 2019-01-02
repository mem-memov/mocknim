import
  macros,
  mocknim/[
    original/dependencyOriginal
  ]

type
  ModuleOriginal* = ref object
    dependencyOriginals: seq[DependencyOriginal]
    name: string


proc newModuleOriginal*(statementsNode: NimNode, name: string, dependencyOriginals: seq[DependencyOriginal]): ModuleOriginal =

  ModuleOriginal(
    dependencyOriginals: dependencyOriginals,
    name: name
  )


proc dependencies*(this: ModuleOriginal): seq[DependencyOriginal] =

  this.dependencyOriginals