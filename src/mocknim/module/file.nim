import 
  macros,
  ospaths,
  strutils

type
  File* = ref object
    path: string


proc newFile*(path: string): File = 

  File(
    path: path
  )


proc exists*(this: File): bool =
  
  let path = unixToNativePath(
    parentDir(
      parentDir(
        parentDir(
          parentDir(
            currentSourcePath()
          )
        ) 
      )
    ) & strip(this.path, true, false, {'.'})
  )
  
  let command = "test -e " & path & " && echo success || echo failure"

  "success" == staticExec(command)

proc moduleTypeName*(this: File): string =

  var (dir, name, ext) = splitFile(this.path)

  result = capitalizeAscii(name)
  

proc loadAst*(this: File): NimNode = 
  
  let file = staticRead(this.path)
  
  result = parseStmt(file)
