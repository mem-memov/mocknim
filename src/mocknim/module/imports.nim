import
  macros,
  sequtils,
  mocknim/[
    module/file,
    module/directory
  ]

type
  File = file.File # disambiguate
  Imports* = ref object
    ast: NimNode
    directory: Directory

proc newImports*(ast: NimNode, directory: Directory): Imports =
 
  Imports(
    ast: ast,
    directory: directory
  )


proc compose(node: NimNode, prefix: string, moduleNames: var seq[string])
proc files*(this: Imports): seq[File] =

  result = @[]

  for importStmtNode in this.ast:

    if importStmtNode.kind == nnkImportStmt:

      var moduleNames: seq[string] = @[]

      compose(importStmtNode, "", moduleNames)

      for moduleName in moduleNames:

        let file = this.directory.getFile(moduleName)

        result.add(file)

  
proc compose(node: NimNode, prefix: string, moduleNames: var seq[string]) =

  for subnode in node:

    case subnode.kind

    of nnkIdent:

      moduleNames.add( prefix & $subnode )

    of nnkInfix:

      if subnode[0].kind == nnkIdent and subnode[1].kind == nnkIdent and subnode[2].kind == nnkBracket:
        compose(
          subnode[2], 
          $subnode[1] & $subnode[0], 
          moduleNames
        )

      if subnode[0].kind == nnkIdent and subnode[1].kind == nnkIdent and subnode[2].kind == nnkIdent:
        moduleNames.add( prefix & $subnode[1] & $subnode[0] & $subnode[2] )

    else:
      raise newException(Exception, "unknown token in import statement")

    
