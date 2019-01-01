import 
  macros,
  mocknim/[
    module/directory,
    module/file,
    original/procedure
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

      #skip private
      if node[0].kind != nnkPostfix:
        continue

      let nodeProcedureName = node[0][1].repr()

      if nodeProcedureName == procedureName:
    
        return newProcedure(node, this.name)

  raise newException(Exception, "Procedure not found - " & procedureName)