import 
  macros
  

type
  Procedure* = ref object
    node: NimNode


proc newProcedure*(node: NimNode): Procedure =

  Procedure(
    node: node
  )

proc mock*(this: Procedure) =

  echo this.node.treeRepr()
  let resultType = this.node[3][0].repr()
  for i, argument in this.node[3]:
    if i == 0:
      continue
    let argumentName = argument[1].repr
    let argumentType = argument[0].repr
    echo argumentType
    # echo argument.treeRepr()