import 
  macros,
  mocknim/[
    module/directory,
    module/file,
    original/procedureOriginal
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

proc procedure*(this: Module, procedureName: string): ProcedureOriginal =
  
  let file = this.directory.file(this.name)

  let ast = file.loadAst()

  for node in ast:

    if node.kind == nnkProcDef:

      #skip private
      if node[0].kind != nnkPostfix:
        continue

      let nodeProcedureName = node[0][1].repr()

      if nodeProcedureName == procedureName:
    
        return newProcedureOriginal(node, this.name)

  raise newException(Exception, "Procedure not found - " & procedureName)