import 
  macros,
  mocknim/[
    original/self
  ]

type
  Arguments* = ref object
    node: NimNode

proc newArguments*(node: NimNode):Arguments =

  Arguments(
    node: node
  )

proc exist*(this: Arguments, selfExists: bool): bool =

  for i, node in this.node:

    if node.kind != nnkFormalParams:
      continue

    if i == 0: # skip return type
      continue

    if i == 1 and selfExists: # skip self argument
      continue

    return true

  return false

proc mockTypes*(this: Arguments, selfExists: bool) =

  for i, formalParams in this.node:

    if formalParams.kind != nnkFormalParams:
      continue

    for j, identDefs in formalParams:

      if j == 0: # skip return type
        continue

      if j == 1 and selfExists: # skip self argument
        continue

      let typeName = identDefs[1].repr()

      # let typeDefinition = newTypeDefinition(typeName)

      # if typeDefinition.isCapitalized():
      #   yield typeDefinition.mock()

