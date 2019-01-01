import 
  mocknim/module/file


type
  Directory* = ref object
    path: string


proc newDirectory*(path: string): Directory =

  Directory(
    path: path
  )


proc file*(this: Directory, name: string): file.File =

  file.newFile(
    this.path & "/" & name & ".nim"
  )