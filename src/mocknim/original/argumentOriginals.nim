import 
  macros,
  mocknim/[
    original/argumentOriginal
  ]


type
  ArgumentOriginals* = ref object
    formalParamsNode: NimNode


proc newArgumentOriginals*(formalParamsNode: NimNode): ArgumentOriginals =

  expectKind(formalParamsNode, nnkFormalParams)

  ArgumentOriginals(
    formalParamsNode: formalParamsNode
  )


proc create*(this: ArgumentOriginals): seq[ArgumentOriginal] =

  result = @[]

  for identDefsNode in this.formalParamsNode:

    if identDefsNode.kind == nnkIdentDefs:
      let indexInSignature = result.len()
      result.add(newArgumentOriginal(indexInSignature, identDefsNode))