import 
  mocknim/[
    original/dependencyOriginal
  ]

type
  DependencyOriginals* = ref object
    list: seq[DependencyOriginal]

proc newDependencyOriginals*(list: seq[DependencyOriginal]): DependencyOriginals = 

  DependencyOriginals(
    list: list
  )