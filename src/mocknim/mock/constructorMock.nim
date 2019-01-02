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

  let moduleTypeName = this.dependencyOriginal.moduleTypeName()

  result = nnkProcDef.newTree(
    newIdentNode("mock" & moduleTypeName),
    newEmptyNode(),
    newEmptyNode(),
    nnkFormalParams.newTree(
      newIdentNode(moduleTypeName)
    ),
    newEmptyNode(),
    newEmptyNode(),
    nnkStmtList.newTree(
      nnkCall.newTree(
        newIdentNode(moduleTypeName)
      )
    )
  )


  