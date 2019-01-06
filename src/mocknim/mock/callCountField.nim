import
  macros,
  mocknim/[
    original/dependencyOriginal,
    original/procedureOriginal,
    original/signatureOriginal
  ]


type 
  CallCountField* = ref object
    dependencyOriginal: DependencyOriginal


proc newCallCountField*(dependencyOriginal: DependencyOriginal): CallCountField =

  CallCountField(
    dependencyOriginal: dependencyOriginal
  )


proc generate*(this: CallCountField): NimNode =

  var counts: seq[NimNode] = @[]

  for procedureOriginal in this.dependencyOriginal.getProcedures():

    counts.add(
      nnkIdentDefs.newTree(
        newIdentNode(procedureOriginal.signature().getProcedureName()),
        newIdentNode("int"),
        newEmptyNode()
      )
    )

  result = nnkIdentDefs.newTree(
    newIdentNode("callCount"),
    nnkTupleTy.newTree(
      counts
    ),
    newEmptyNode()
  )



  # dumpAstGen:
  #   type
  #     Directory = ref object
  #       callCount: tuple[newDirectory: int]