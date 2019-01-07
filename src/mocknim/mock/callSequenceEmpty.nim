import
  macros,
  mocknim/[
    original/dependencyOriginal
  ]

type
  CallSequenceEmpty* = ref object
    dependencyOriginal: DependencyOriginal


proc newCallSequenceEmpty*(dependencyOriginal: DependencyOriginal): CallSequenceEmpty = 

  CallSequenceEmpty(
    dependencyOriginal: dependencyOriginal
  )


proc generate*(): NimNode =

  for procedureOriginal in this.dependencyOriginal.getProcedures():

    let procedureName = procedureOriginal.getSignature().getProcedureName()

    var arguments: seq[NimNode] = @[]

    for ai, argumentOriginal in procedureOriginal.getArguments():

      let argumentName = argumentOriginal.getArgumentName()

      if moduleTypeName == typeNameNode.repr() and ai == 0: # skip "this" argument
        continue


  newEmptyNode()