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

  result[0] = newIdentNode(this.signatureOriginal.procedureName()) # remove asterisk

  let moduleTypeName = this.selfOriginal.moduleTypeName()

  var body: NimNode = newEmptyNode()

  if not this.selfOriginal.exists() and 
    this.resultOriginal.exists() and
    this.resultOriginal.typeName() == moduleTypeName:

    body = newFactoryTemplate(
      this.selfOriginal.moduleTypeName(),
      this.signatureOriginal.procedureName()
    ).generate()

  if this.selfOriginal.exists() and
    this.resultOriginal.exists():

    body = newResultActionTemplate(
      this.selfOriginal.moduleTypeName(),
      this.signatureOriginal.procedureName(),
      this.selfOriginal.parameterName(),
      this.resultOriginal.typeName()
    ).generate(
      newEmptyNode()
    )


  result[6] = newStmtList(body)

  # echo result.repr()
