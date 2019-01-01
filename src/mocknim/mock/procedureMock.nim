import
  macros,
  mocknim/[
    original/signatureOriginal,
    original/resultOriginal,
    original/argumentOriginal
  ]


type
  ProcedureMock* = ref object
    signatureOriginal: SignatureOriginal
    resultOriginal: ResultOriginal
    argumentOriginal: seq[ArgumentOriginal]


proc newProcedureMock*(
  signatureOriginal: SignatureOriginal, 
  resultOriginal: ResultOriginal,
  argumentOriginal: seq[ArgumentOriginal]
  ): ProcedureMock = 

  ProcedureMock(
    signatureOriginal: signatureOriginal,
    resultOriginal: resultOriginal,
    argumentOriginal: argumentOriginal
  )


proc generate*(this: ProcedureMock): NimNode =

  result = this.signatureOriginal.copy()

  result[0] = newIdentNode(this.signatureOriginal.procedureName())

  var statements = newStmtList()

  if this.resultOriginal.exists():

    let self = this.argumentOriginal[0]

    statements.add(
      newTree(nnkAsgn,
        newIdentNode("result"),
        newTree(nnkDotExpr,
          newIdentNode(self.argumentName()),
          newIdentNode("result")
        )
      )
    )

  result[6] = statements
