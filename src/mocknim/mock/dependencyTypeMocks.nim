import
  macros,
  mocknim/[
    original/dependencyOriginal
  ]

type
  DependencyTypeMocks* = ref object
    dependencyOriginals: seq[DependencyOriginal]


proc newDependencyTypeMocks*(dependencyOriginals: seq[DependencyOriginal]): DependencyTypeMocks =

  DependencyTypeMocks(
    dependencyOriginals: dependencyOriginals
  )


proc generate*(this: DependencyTypeMocks): Nimnode =

  newEmptyNode()