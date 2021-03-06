import
  macros,
  mocknim/[
    original/signatureOriginal,
    original/resultOriginal,
    original/argumentOriginal,
    original/selfOriginal,
    templates/factoryTemplate,
    templates/resultActionTemplate,
    templates/actionTemplate,
    templates/argumentAssertionTemplate
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

  let moduleTypeName = this.selfOriginal.getModuleTypeName()
  let procedureName = this.signatureOriginal.getProcedureName()

  result[0] = newIdentNode(procedureName) # remove asterisk

  var body: NimNode = newEmptyNode()

  var argumentAssertions = newStmtList()
  for index, argumentOriginal in this.argumentOriginals:
    if this.selfOriginal.exists() and index == 0: # skip self argument
      continue
    argumentAssertions.add(
      newArgumentAssertionTemplate(
        argumentOriginal, 
        this.selfOriginal, 
        moduleTypeName, 
        this.signatureOriginal.getProcedureName()
      ).generate()
    )

  if not this.selfOriginal.exists() and 
    this.resultOriginal.exists() and
    this.resultOriginal.getTypeName() == moduleTypeName:

    body = newFactoryTemplate(
      moduleTypeName,
      procedureName
    ).generate(
      argumentAssertions
    )

  if this.selfOriginal.exists() and
    this.resultOriginal.exists():

    body = newResultActionTemplate(
      moduleTypeName,
      procedureName,
      this.selfOriginal.getParameterName()
    ).generate(
      argumentAssertions
    )

  if this.selfOriginal.exists() and
    not this.resultOriginal.exists():

    body = newActionTemplate(
      moduleTypeName,
      procedureName,
      this.selfOriginal.getParameterName()
    ).generate(
      argumentAssertions
    )

  result[6] = newStmtList(body)


  # echo result.repr()
