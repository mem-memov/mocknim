import
  macros,
  strutils

type
  Patch* = ref object
    representation: string

proc newPatch*(node: NimNode): Patch =

  Patch(
    representation: node.repr()
  )

proc insert*(this: Patch, placeHolder: string, patch: Patch): Patch =

  result = this

  let mark = "echo \"" & placeHolder & "\""
  this.representation = replace(this.representation, mark, patch.representation)


proc append*(this: Patch, patch: Patch): Patch =

  result = this

  this.representation &= patch.representation


proc tree*(this: Patch): NimNode =

  this.representation.parseStmt()


proc print*(this: Patch): Patch =

  result = this

  echo this.representation