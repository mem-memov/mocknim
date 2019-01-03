import
  macros,
  mocknim/[
    original/dependencyOriginal,
    mock/callCountZero
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

  let callCountZero = newCallCountZero(this.dependencyOriginal)

  let assignMockNode = nnkVarSection.newTree(
    nnkIdentDefs.newTree(
      nnkPragmaExpr.newTree(
        newIdentNode("mock"),
        nnkPragma.newTree(
          newIdentNode("global")
        )
      ),
      newEmptyNode(),
      callCountZero.generate()
    )
  )

  let setResultNode = nnkAsgn.newTree(
    newIdentNode("result"),
    newIdentNode("mock")
  )

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
      assignMockNode,
      setResultNode
    )
  )

  echo result.repr()

  dumpAstGen:
    proc mockDirectory(): Directory =
      var mock {.global.} = Directory(
        callCount: (
          getFiles: 0
        )
      )
      result = mock


