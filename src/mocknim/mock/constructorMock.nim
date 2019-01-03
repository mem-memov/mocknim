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
          nnkObjConstr.newTree(
            newIdentNode(moduleTypeName),
            nnkExprColonExpr.newTree(
              newIdentNode("callCount"),
              newLit(0)
            )
          )
        )
      ),
      nnkAsgn.newTree(
        newIdentNode("result"),
        newIdentNode("mock")
      )
    )
  )

  echo result.repr()

  # dumpAstGen:
  #   proc mockDirectory(): Directory =
  #     var mock {.global.} = Directory(
  #       callCount: 0
  #     )
  #     result = mock


