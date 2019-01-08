import
  macros,
  mocknim/[
    mock/finalizer,
    original/dependencyOriginal
  ]


type
  Finalizers* = ref object
    dependencyOriginals: seq[DependencyOriginal]


proc newFinalizers*(dependencyOriginals: seq[DependencyOriginal]): Finalizers = 

  Finalizers(
    dependencyOriginals: dependencyOriginals
  )


proc generate*(this: Finalizers): seq[NimNode] =

  for dependencyOriginal in this.dependencyOriginals:

    let finalizer = newFinalizer(dependencyOriginal)

    result.add(finalizer.generate())
