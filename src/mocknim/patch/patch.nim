import
  macros,
  strutils,
  mocknim/[
    patch/replacement
  ]

type
  Patch* = ref object
    node: NimNode

proc newPatch*(node: NimNode): Patch =

  Patch(
    node: node
  )

proc insert*(this: Patch, placeHolder: string, patch: Patch): Patch =

  result = this

  newReplacement(this.node).apply(placeHolder, patch.node)


proc tree*(this: Patch): NimNode =

  this.node
