import 
  macros,
  mocknim/[
    factory,
    procedure/procedure
  ]

macro mock*(moduleNode: string, procedureNode: string): untyped =

  let factory = newFactory()

  let procedure = factory.procedure(moduleNode, procedureNode)

  result = procedure.mock()





