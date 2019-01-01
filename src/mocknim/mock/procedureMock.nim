import
  macros,
  mocknim/[
    original/signatureOriginal,
    original/resultOriginal
  ]


type
  ProcedureMock* = ref object
    signatureOriginal: SignatureOriginal
    resultOriginal: ResultOriginal


proc newProcedureMock*(
  signatureOriginal: SignatureOriginal, 
  resultOriginal: ResultOriginal
  ): ProcedureMock = 

  ProcedureMock(
    signatureOriginal: signatureOriginal,
    resultOriginal: resultOriginal
  )


proc generate*(this: ProcedureMock): NimNode =

  result = this.signatureOriginal.copy()

  result[0] = newIdentNode(this.signatureOriginal.procedureName())

  var statements = newStmtList()

  if this.resultOriginal.exists():
    statements.add(
      newTree(nnkAsgn,
        newIdentNode("result"),
        newTree(nnkDotExpr,
          newIdentNode("this"),
          newIdentNode("result")
        )
      )
    )

  result[6] = statements
