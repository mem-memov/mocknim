import macros


type
  File* = ref object
    path: string


proc newFile*(path: string): File = 

  File(
    path: path
  )


proc loadAst*(this: File): NimNode = 

  let file = staticRead(this.path)
  result = parseStmt(file)
  # echo result.treeRepr()