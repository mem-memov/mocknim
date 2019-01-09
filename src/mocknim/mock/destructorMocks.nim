import
  macros,
  mocknim/[
    original/dependencyOriginal,
    mock/destructorMock
  ]


type
  DestructorMocks* = ref object
    dependencyOriginals: seq[DependencyOriginal]


proc newDestructorMocks*(dependencyOriginals: seq[DependencyOriginal]): DestructorMocks = 

  DestructorMocks(
    dependencyOriginals: dependencyOriginals
  )


proc generate*(this: DestructorMocks): seq[NimNode] =  

  for dependencyOriginal in this.dependencyOriginals:

    let destructorMock = newDestructorMock(dependencyOriginal)

    result.add(destructorMock.generate())

  