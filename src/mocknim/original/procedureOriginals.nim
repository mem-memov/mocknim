import
  macros,
  mocknim/[
    original/procedureOriginal
  ]


type
  ProcedureOriginals* = ref object
    statementsNode: NimNode


proc newProcedureOriginals*(statementsNode: NimNode): ProcedureOriginals =

  ProcedureOriginals(
    statementsNode: statementsNode
  )


proc create*(this: ProcedureOriginals, moduleName: string): seq[ProcedureOriginal] =

  result = @[]

  for procDefNode in this.statementsNode:

    if procDefNode.kind == nnkProcDef:

      result.add(
        newProcedureOriginal(procDefNode, moduleName)
      )
