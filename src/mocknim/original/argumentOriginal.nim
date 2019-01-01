import 
  macros


type
  ArgumentOriginal* = ref object
    identDefsNode: NimNode


proc newArgumentOriginal*(identDefsNode: NimNode): ArgumentOriginal =

  expectKind(identDefsNode, nnkIdentDefs)

  ArgumentOriginal(
    identDefsNode: identDefsNode
  )