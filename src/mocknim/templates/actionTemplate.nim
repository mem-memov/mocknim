import
  macros,
  mocknim/[
    patch/patch
  ]


type
  ActionTemplate* = ref object
    procedureName: string
    selfParameterName: string


proc newActionTemplate*(procedureName: string, selfParameterName: string): ActionTemplate =

  ActionTemplate(
    procedureName: procedureName,
    selfParameterName: selfParameterName
  )


proc mockAction(
  procedureName: string,
  selfParameterName: string): NimNode =

  var procedure = procedureName.ident()
  var mock = selfParameterName.ident()
  var expectedParameters = "expectedParameters".ident()

  result = quote:
    echo "call " & `procedureName`

    var count = `mock`.callCount.`procedure`
    var countLimit = `mock`.expects.`procedure`.len()

    if count < countLimit:
      let `expectedParameters` = `mock`.expects.`procedure`[count][0]

      echo "insert argument check here"

      `mock`.callCount.`procedure` = count + 1

    else:
      echo "unexpected call to " & `procedureName`


proc generate*(this: ActionTemplate, argumentCheckNode: NimNode): NimNode =

  result = newPatch(
    mockAction(
      this.procedureName,
      this.selfParameterName
    )
  )
  .insert("insert argument check here", newPatch(argumentCheckNode))
  .getTree()

  # echo result.repr()

