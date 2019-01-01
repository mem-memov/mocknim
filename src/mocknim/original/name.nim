type
  Name* = ref object
    node: NimNode

proc newName*(node: NimNode): Name = 

  Name(
    node: node
  )