import 
  mocknim/module/file


type
  File = file.File # disambiguate
  Directory* = ref object
    path: string


proc newDirectory*(path: string): Directory =

  Directory(
    path: path
  )


proc getFile*(this: Directory, moduleName: string): File =

  let path = this.path & "/" & moduleName & ".nim"

  result = file.newFile(moduleName, path)