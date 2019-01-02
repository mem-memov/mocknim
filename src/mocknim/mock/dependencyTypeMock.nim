import
  macros,
  mocknim/[
    original/dependencyOriginal
  ]


type
  DependencyTypeMock* = ref object
    dependencyOriginal: DependencyOriginal


proc newDependencyTypeMock*(dependencyOriginal: DependencyOriginal): DependencyTypeMock =

  DependencyTypeMock(
    dependencyOriginal: dependencyOriginal
  )


proc generate*(this: DependencyTypeMock): NimNode =

  result = newTree(nnkTypeDef,
    newIdentNode(this.dependencyOriginal.moduleTypeName()),
    newEmptyNode(),
    newTree(nnkRefTy,
      newTree(nnkObjectTy,
        newEmptyNode(),
        newEmptyNode(),
        newEmptyNode()
      )
    )
  )