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
      nnkVarSection.newTree(
        nnkIdentDefs.newTree(
          nnkPragmaExpr.newTree(
            newIdentNode("mock"),
            nnkPragma.newTree(
              newIdentNode("global")
            )
          ),
          newEmptyNode(),
          nnkCall.newTree(
            newIdentNode(moduleTypeName)
          )
        )
      ),
      nnkAsgn.newTree(
        newIdentNode("result"),
        newIdentNode("mock")
      )
    )
  )


  