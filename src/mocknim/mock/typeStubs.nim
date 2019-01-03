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

  var allTypes: seq[string] = @[]
  var excludedTypes: seq[string] = @[]

  for dependencyOriginal in this.moduleOriginal.dependencies():
    
    excludedTypes.add(dependencyOriginal.moduleTypeName())

    for procedureOriginal in dependencyOriginal.procedures():

      allTypes = allTypes.concat(procedureOriginal.allTypeNames())

  allTypes = allTypes.deduplicate()
  excludedTypes = excludedTypes.deduplicate()

  var types = allTypes.filter(proc (item: string): bool = item notin excludedTypes and item[0].isUpperAscii())

  echo allTypes.repr()
  echo excludedTypes.repr()
  echo types.repr()

  newEmptyNode()