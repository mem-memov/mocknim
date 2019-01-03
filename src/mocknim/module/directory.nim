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


proc file*(this: Directory, name: string): File =

  file.newFile(
    this.path & "/" & name & ".nim"
  )

proc removeMeIAmForTesting*(this: Directory) =

  echo "removeMeIAmForTesting"