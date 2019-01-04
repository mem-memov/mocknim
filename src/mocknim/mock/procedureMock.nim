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


template mockProcedure(moduleName: untyped, procedureName: untyped, variableName: untyped, selfExists: int): untyped =

    if not (selfExists == 1):
      var variableName = `mock moduleName`()
      echo variableName.repr()

    # var count = variableName.callCount.procedureName

    

    # let expectedParameters = variableName.expects.procedureName[count][0]
    # let expectedReturnValue = variableName.expects.procedureName[count][1]

    # variableName.callCount.procedureName += 1



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

  var selfExists:int
  if this.selfOriginal.exists():
    selfExists = 1
  else:
    selfExists = 0

  var body = getAst(mockProcedure(
    this.selfOriginal.moduleTypeName().ident,
    this.signatureOriginal.procedureName().ident,
    variableName.ident,
    selfExists
  ))

  statements.add(body)

  # echo body.repr()

  result[6] = statements

  # echo result.repr()
