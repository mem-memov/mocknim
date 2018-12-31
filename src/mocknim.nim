import 
  macros,
  mocknim/[
    module, 
    directory
  ]


macro mock*(moduleNode: string, procedureNode: string): untyped =
  result = newStmtList()

  let directory = newDirectory("../src")

  let module = newModule(moduleNode, directory)

  module.mockProcedure(procedureNode)


