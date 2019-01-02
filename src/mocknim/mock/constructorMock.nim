import
  macros,
  mocknim/[
    original/dependencyOriginal
  ]


type
  ConstructorMock* = ref object
    dependencyOriginal: DependencyOriginal


proc newConstructorMock*(dependencyOriginal: DependencyOriginal): ConstructorMock = 

  ConstructorMock(
    dependencyOriginal: dependencyOriginal
  )


proc generate*(this: ConstructorMock): NimNode =

  newEmptyNode()
  