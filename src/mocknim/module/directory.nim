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


proc getFile*(this: Directory, name: string): File =

  file.newFile(
    this.path & "/" & name & ".nim"
  )