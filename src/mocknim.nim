import 
  macros,
  mocknim/[
    module, 
    procedure,
    directory
  ]

macro mock*(moduleNode: string, procedureNode: string): untyped =

  let directory = newDirectory("../src")

  let module = newModule(moduleNode, directory)

  let procedure = module.procedure(procedureNode)

  result = procedure.mock()





