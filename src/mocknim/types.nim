import 
  macros

type
  Types* = ref object
    list: seq[string]

proc newTypes*(list: seq[string]): Types =

  Types(
    list: list
  )

proc mock*(this: Types, node: NimNode): NimNode =

  var definitions: seq[NimNode] = @[]

  for name in this.list:

    if name == "":
      continue

    let definition = newTree(nnkTypeDef,
      newIdentNode(name),
      newEmptyNode(),
      newTree(nnkRefTy,
        newTree(nnkObjectTy,
          newEmptyNode(),
          newEmptyNode(),
          newEmptyNode()
        )
      )
    )

    definitions.add(definition)

  result = newTree(nnkTypeSection, definitions)