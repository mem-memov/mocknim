import 
  macros,
  sequtils,
  strutils,
  mocknim/[
    original/typeOriginals,
    original/name,
    original/self,
    original/arguments
  ]


type
  ProcedureOriginal* = ref object
    name: Name
    self: Self
    arguments: Arguments
    typeOriginals: TypeOriginals



proc newProcedureOriginal*(procDefNode: NimNode, moduleName: string): ProcedureOriginal =

  expectKind(procDefNode, nnkProcDef)

  let nameParts = moduleName.split("/")
  let moduleTypeName = capitalizeAscii(nameParts[nameParts.high])

  ProcedureOriginal(
    name: newName(procDefNode),
    self: newSelf(procDefNode, moduleTypeName),
    arguments: newArguments(procDefNode),
    typeOriginals: newTypeOriginals(procDefNode[3])
  )


proc allTypeNames*(this: ProcedureOriginal): seq[string] = 

  result = this.typeOriginals.collectTypeNames()



proc mock*(this: ProcedureOriginal): NimNode =

  result = newStmtList()

  let selfExists = this.self.exists()

  if this.arguments.exist(selfExists):
    this.arguments.mockTypes(selfExists)

  if selfExists:
    echo "eeeeeeeeeee"

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