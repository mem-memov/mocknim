import 
  macros,
  ospaths,
  strutils

type
  File* = ref object
    moduleName: string
    path: string


proc newFile*(moduleName: string, path: string): File = 
  
  File(
    moduleName: moduleName,
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

proc getModuleTypeName*(this: File): string =

  var (dir, name, ext) = splitFile(this.path)

  result = capitalizeAscii(name)
  

proc loadAst*(this: File): NimNode = 
  
  let file = staticRead(this.path)
  
  result = parseStmt(file)


proc getModuleName*(this: File): string = 

  this.moduleName
