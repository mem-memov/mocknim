import 
  macros,
  mocknim/[
    module/directory,
    module/file,
    procedure/procedure
  ]


type
  Module* = ref object
    name: string
    directory: Directory


proc newModule*(name: string, directory: Directory): Module =

  Module(
    name: name,
    directory: directory
  )

proc procedure*(this: Module, procedureName: string): Procedure =
  
  let file = this.directory.file(this.name)

  let ast = file.loadAst()

  for node in ast:

    if node.kind == nnkProcDef:

      let nodeProcedureName = node[0][1].repr()

      if nodeProcedureName == procedureName:

        return newProcedure(node)

  raise newException(Exception, "Procedure not found " & procedureName)