import
  macros,
  mocknim/[
    original/dependencyOriginal,
    unmock/constructorUnmock
  ]


type
  ConstructorUnmocks* = ref object
    dependencyOriginals: seq[DependencyOriginal]


proc newConstructorUnmocks*(dependencyOriginals: seq[DependencyOriginal]): ConstructorUnmocks = 

  ConstructorUnmocks(
    dependencyOriginals: dependencyOriginals
  )


proc unleashGarbageCollector(): NimNode =

  result = quote:

    GC_fullCollect()


proc generate*(this: ConstructorUnmocks): seq[NimNode] =

  for dependencyOriginal in this.dependencyOriginals:

    let constructorUnmock = newConstructorUnmock(dependencyOriginal)

    result.add(constructorUnmock.generate())

  result.add(unleashGarbageCollector())

  