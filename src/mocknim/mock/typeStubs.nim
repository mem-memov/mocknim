import 
  macros,
  sequtils,
  strutils,
  mocknim/[
    original/moduleOriginal,
    original/dependencyOriginal,
    original/procedureOriginal
  ]


type
  TypeStubs* = ref object
    moduleOriginal: ModuleOriginal


proc newTypeStabs*(moduleOriginal: ModuleOriginal): TypeStubs =

  TypeStubs(
    moduleOriginal: moduleOriginal
  )


proc generate*(this: TypeStubs): NimNode =

  let externalDependencies = this.moduleOriginal.getExternalDependencies()

  var allTypes: seq[string] = @[]
  var excludedTypes: seq[string] = @[]

  for dependencyOriginal in this.moduleOriginal.getDependencies():
    
    excludedTypes.add(dependencyOriginal.getModuleTypeName())

    for procedureOriginal in dependencyOriginal.getProcedures():

      allTypes = allTypes.concat(procedureOriginal.getAllTypeNames())

  allTypes = allTypes.deduplicate()
  excludedTypes = excludedTypes.deduplicate()

  var types = allTypes.filter(proc (item: string): bool = item notin excludedTypes and item[0].isUpperAscii())

  var typeNodes: seq[NimNode] = @[]

  for typeName in types:

    typeNodes.add(
      nnkTypeDef.newTree(
        newIdentNode(typeName),
        newEmptyNode(),
        nnkRefTy.newTree(
          nnkObjectTy.newTree(
            newEmptyNode(),
            newEmptyNode(),
            newEmptyNode()
          )
        )
      )
    )

  result = nnkTypeSection.newTree(
    typeNodes
  )

