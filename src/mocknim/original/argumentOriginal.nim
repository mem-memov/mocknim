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


proc argumentName*(this: ArgumentOriginal): string =

  this.identDefsNode[0].repr()


proc typeName*(this: ArgumentOriginal): string =

  this.identDefsNode[1].repr()