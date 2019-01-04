import
  macros,
  mocknim/[
    original/signatureOriginal,
    original/resultOriginal,
    original/argumentOriginal,
    original/selfOriginal
  ]


type
  ProcedureMock* = ref object
    signatureOriginal: SignatureOriginal
    resultOriginal: ResultOriginal
    argumentOriginal: seq[ArgumentOriginal]
    selfOriginal: SelfOriginal


proc newProcedureMock*(
  signatureOriginal: SignatureOriginal, 
  resultOriginal: ResultOriginal,
  argumentOriginal: seq[ArgumentOriginal],
  selfOriginal: SelfOriginal
  ): ProcedureMock = 

  ProcedureMock(
    signatureOriginal: signatureOriginal,
    resultOriginal: resultOriginal,
    argumentOriginal: argumentOriginal,
    selfOriginal: selfOriginal
  )


template mockFactory(moduleName: untyped, procedureName: untyped, procedure: string): untyped =

    var mock = `mock moduleName`()

    var count = mock.callCount.procedureName

    var countLimit = mock.expects.procedureName.len()

    if count < countLimit:
      let expectedParameters = mock.expects.procedureName[count][0]
      let expectedReturnValue = mock.expects.procedureName[count][1]

      mock.callCount.procedureName = count + 1

    else:
      echo "unexpected call to " & procedure

proc generate*(this: ProcedureMock): NimNode =

  result = this.signatureOriginal.copy()

  result[0] = newIdentNode(this.signatureOriginal.procedureName())

  var statements = newStmtList()

  var variableName: string
  if this.selfOriginal.exists():
    variableName = this.selfOriginal.parameterName()
  else:
    variableName = "mock12345" # TODO: must be different from any argument name

  let getMockNode = nnkVarSection.newTree(
    nnkIdentDefs.newTree(
      newIdentNode(variableName), # <--
      newEmptyNode(),
      nnkCall.newTree(
        newIdentNode("mock" & this.selfOriginal.moduleTypeName()) # <--
      )
    )
  )

  # if not this.selfOriginal.exists():

  #   statements.add(getMockNode)

  

  # if this.resultOriginal.exists() and this.selfOriginal.exists():

  #   let self = this.argumentOriginal[0]

  #   statements.add(
  #     newTree(nnkAsgn,
  #       newIdentNode("result"),
  #       newTree(nnkDotExpr,
  #         newIdentNode(self.argumentName()),
  #         newIdentNode("result")
  #       )
  #     )
  #   )


  if this.selfOriginal.exists():

    var body = getAst(mockFactory(
      this.selfOriginal.moduleTypeName().ident,
      this.signatureOriginal.procedureName().ident,
      this.signatureOriginal.procedureName()
    ))

    statements.add(body)

  # echo body.repr()

  result[6] = statements

  # echo result.repr()
