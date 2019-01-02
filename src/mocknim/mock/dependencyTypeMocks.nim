import
  macros,
  sequtils,
  mocknim/[
    mock/dependencyTypeMock,
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

  var definitions: seq[NimNode] = @[]

  for dependencyOriginal in this.dependencyOriginals:

    let dependencyTypeMock = newDependencyTypeMock(dependencyOriginal)

    definitions.add(dependencyTypeMock.generate())

  result = newTree(nnkTypeSection, definitions)