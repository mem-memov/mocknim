import
  macros,
  mocknim/[
    original/signatureOriginal
  ]


type
  ProcedureMock* = ref object
    signatureOriginal: SignatureOriginal


proc newProcedureMock*(signatureOriginal: SignatureOriginal): ProcedureMock = 

  ProcedureMock(
    signatureOriginal: signatureOriginal
  )


proc generate*(this: ProcedureMock): NimNode =

  result = this.signatureOriginal.copy()

  result[0] = newIdentNode(this.signatureOriginal.procedureName())