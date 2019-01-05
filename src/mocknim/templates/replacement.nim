import
  macros


type
  Replacement* = ref object
    node: NimNode


proc newReplacement*(node: NimNode): Replacement =

  Replacement(
    node: node
  )


proc walk(node: NimNode, placeHolder: string, value: NimNode) =

  for index, child in node.pairs():
    
    if child.repr() == "echo \"" & placeHolder & "\"":
      node[index] = value
      return;

    walk(child, placeHolder, value)


proc apply*(this: Replacement, placeHolder: string, value: NimNode) =

  walk(this.node, placeHolder, value)