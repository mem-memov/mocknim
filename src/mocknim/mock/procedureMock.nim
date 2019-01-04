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

  block:
    var mock = `mock moduleName`()
    var count = mock.callCount.procedureName
    var countLimit = mock.expects.procedureName.len()

    if count < countLimit:
      let expectedParameters = mock.expects.procedureName[count][0]
      let expectedReturnValue = mock.expects.procedureName[count][1]

      mock.callCount.procedureName = count + 1

    else:
      echo "unexpected call to " & procedure

    result = mock


template mockAction(
  moduleName: untyped, 
  procedureName: untyped, 
  procedure: string, 
  mock: untyped,
  returnType: untyped): untyped =

  block:
    var count = mock.callCount.procedureName
    var countLimit = mock.expects.procedureName.len()
    echo "---------------------------" & procedure
    if count < countLimit:
      let expectedParameters = mock.expects.procedureName[count][0]
      var returnValue: returnType
      returnValue = mock.expects.procedureName[count][1]

      mock.callCount.procedureName = count + 1

      result = returnValue

    else:
      echo "unexpected call to " & procedure


proc generate*(this: ProcedureMock): NimNode =

  result = this.signatureOriginal.copy()

  result[0] = newIdentNode(this.signatureOriginal.procedureName()) # remove asterisk

  let moduleTypeName = this.selfOriginal.moduleTypeName()

  var body: NimNode

  if not this.selfOriginal.exists() and 
    this.resultOriginal.exists() and
    this.resultOriginal.typeName() == moduleTypeName:

    body = getAst(mockFactory(
      this.selfOriginal.moduleTypeName().ident,
      this.signatureOriginal.procedureName().ident,
      this.signatureOriginal.procedureName()
    ))

  if this.selfOriginal.exists():

    body = getAst(mockAction(
      this.selfOriginal.moduleTypeName().ident,
      this.signatureOriginal.procedureName().ident,
      this.signatureOriginal.procedureName(),
      this.selfOriginal.parameterName().ident,
      this.resultOriginal.typeName().ident
    ))

  result[6] = newStmtList(body)

  echo result.repr()
