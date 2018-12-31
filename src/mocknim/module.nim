import 
  macros,
  strutils,
  mocknim/[
    directory,
    file,
    procedure
  ]


type
  Module* = ref object
    name: string
    directory: Directory


proc newModule*(nameNode: NimNode, directory: Directory): Module =

  let name = nameNode.repr().strip(true, true, {'"'})

  Module(
    name: name,
    directory: directory
  )


proc mockProcedure*(this: Module, nameNode: NimNode) =

  let file = this.directory.file(this.name)

  let ast = file.loadAst()

  let procedureName =  nameNode.repr().strip(true, true, {'"'})

  for node in ast:
  
    if node.kind == nnkProcDef:

      let nodeProcedureName = node[0][1].repr()

      if nodeProcedureName == procedureName:

        let procedure = newProcedure(node)
        procedure.mock()