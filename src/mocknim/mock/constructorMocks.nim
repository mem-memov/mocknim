import
  macros,
  mocknim/[
    original/dependencyOriginal,
    mock/constructorMock
  ]


type
  ConstructorMocks* = ref object
    dependencyOriginals: seq[DependencyOriginal]


proc newConstructorMocks*(dependencyOriginals: seq[DependencyOriginal]): ConstructorMocks = 

  ConstructorMocks(
    dependencyOriginals: dependencyOriginals
  )


proc generate*(this: ConstructorMocks): seq[NimNode] =

  for dependencyOriginal in this.dependencyOriginals:

    let constructorMock = newConstructorMock(dependencyOriginal)

    result.add(constructorMock.generate())
  