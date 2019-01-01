import 
  macros,
  sequtils,
  mocknim/[
    types,
    procedure/name,
    procedure/argument/self
  ]
import
  mocknim/[
    procedure/name,
    procedure/argument/self
  ]
type
  Procedure* = ref object
    name: Name
    self: Self



proc newProcedure*(node: NimNode, moduleName: string): Procedure =

  Procedure(
    name: newName(node),
    self: newSelf(node)
  )



proc mock*(this: Procedure): NimNode =

  result = newStmtList()



#   var allTypes: seq[string] = @[]

#   let resultType = this.node[3][0].repr()
#   allTypes.add(resultType)

#   for i, argument in this.node[3]:

#     if i == 0:
#       continue

#     let argumentType = argument[0].repr()
#     allTypes.add(argumentType)

#   let uniquetypes = allTypes.deduplicate()

#   let types = newTypes(uniquetypes)

#   var statements: seq[NimNode] = @[]
  
#   statements.add(types.mock(this.node))

#   # echo this.node.repr()
#   # echo this.node.treeRepr()

#   let procedureName = this.node[0][1].repr()

#   let definition = newTree(nnkProcDef,
#     newIdentNode(procedureName),
#     newEmptyNode(),
#     newEmptyNode(),
#     newTree(nnkFormalParams,
#       newEmptyNode(),
#     ),
#     newEmptyNode(),
#     newEmptyNode(),
#     newTree(nnkStmtList,
#       newTree(nnkCommand,
#         newIdentNode("echo"),
#         newStrLitNode("Anonymous")
#       )
#     )
#   )

#   # echo definition.repr()

#   statements.add(definition)

#   result = newStmtList(statements)

#   # echo result.treeRepr()

# # dumpTree:
# #   proc myfn() =
# #     echo "Anonymous"