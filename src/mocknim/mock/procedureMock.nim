import
  macros,
  mocknim/[
    original/signatureOriginal,
    original/resultOriginal,
    original/argumentOriginal,
    original/selfOriginal,
    templates/factoryTemplate,
    templates/resultActionTemplate
  ]


type
  ProcedureMock* = ref object
    signatureOriginal: SignatureOriginal
    resultOriginal: ResultOriginal
    argumentOriginals: seq[ArgumentOriginal]
    selfOriginal: SelfOriginal


proc newProcedureMock*(
  signatureOriginal: SignatureOriginal, 
  resultOriginal: ResultOriginal,
  argumentOriginals: seq[ArgumentOriginal],
  selfOriginal: SelfOriginal
  ): ProcedureMock = 

  ProcedureMock(
    signatureOriginal: signatureOriginal,
    resultOriginal: resultOriginal,
    argumentOriginals: argumentOriginals,
    selfOriginal: selfOriginal
  )

proc generate*(this: ProcedureMock): NimNode =

  result = this.signatureOriginal.copy()

  let moduleTypeName = this.selfOriginal.moduleTypeName()
  let procedureName = this.signatureOriginal.procedureName()

  result[0] = newIdentNode(procedureName) # remove asterisk

  var body: NimNode = newEmptyNode()

  if not this.selfOriginal.exists() and 
    this.resultOriginal.exists() and
    this.resultOriginal.typeName() == moduleTypeName:

    body = newFactoryTemplate(
      moduleTypeName,
      procedureName
    ).generate()

  if this.selfOriginal.exists() and
    this.resultOriginal.exists():

    body = newResultActionTemplate(
      moduleTypeName,
      procedureName,
      this.selfOriginal.parameterName(),
      this.resultOriginal.typeName()
    ).generate(
      newEmptyNode()
    )

  result[6] = newStmtList(body)

  # echo result.repr()
