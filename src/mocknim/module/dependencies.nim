import 
  macros,
  mocknim/[
    module/file,
    module/directory,
    original/dependencyOriginals
  ]


type
  Dependencies* = ref object
    directory: Directory


proc newDependencies*(directory: Directory): Dependencies =

  Dependencies(
    directory: directory
  )


proc original*(this: Dependencies, files: seq[file.File]): DependencyOriginals =

  DependencyOriginals()