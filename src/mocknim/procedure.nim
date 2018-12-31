import 
  macros,
  sequtils,
  mocknim/types

type
  Procedure* = ref object
    node: NimNode


proc newProcedure*(node: NimNode): Procedure =

  Procedure(
    node: node
  )


proc mock*(this: Procedure): NimNode =

  var allTypes: seq[string] = @[]

  let resultType = this.node[3][0].repr()
  allTypes.add(resultType)

  for i, argument in this.node[3]:

    if i == 0:
      continue

    let argumentType = argument[0].repr()
    allTypes.add(argumentType)

  let uniquetypes = allTypes.deduplicate()

  let types = newTypes(uniquetypes)

  result = newStmtList(
    types.mock(result)
  )

