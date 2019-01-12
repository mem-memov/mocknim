import
  macros,
  mocknim/[
    patch/patch
  ]


type
  ActionTemplate* = ref object
    moduleName: string
    procedureName: string
    selfParameterName: string


proc newActionTemplate*( 
    moduleName: string, 
    procedureName: string, 
    selfParameterName: string): ActionTemplate =

  ActionTemplate(
    moduleName: moduleName,
    procedureName: procedureName,
    selfParameterName: selfParameterName
  )


proc mockAction(
  moduleName: string,
  procedureName: string,
  selfParameterName: string): NimNode =

  var procedure = procedureName.ident()
  var mock = selfParameterName.ident()
  var expectedParameters = "expectedParameters".ident()
  var count = "count".ident()
  var countLimit = "countLimit".ident()

  result = quote:
    echo "call " & `moduleName` & "." & `procedureName`

    var `count` = `mock`.callCount.`procedure`
    var `countLimit` = `mock`.expects.`procedure`.len() - 1

    if `count` <= `countLimit`:
      let `expectedParameters` = `mock`.expects.`procedure`[`count`][0]

      echo "insert argument check here"

      `mock`.callCount.`procedure` = `count` + 1

    else:
      echo "UNIT TEST: unexpected call to " & `moduleName` & "." & `procedureName`


proc generate*(this: ActionTemplate, argumentCheckNode: NimNode): NimNode =

  result = newPatch(
    mockAction(
      this.moduleName,
      this.procedureName,
      this.selfParameterName
    )
  )
  .insert("insert argument check here", newPatch(argumentCheckNode))
  .getTree()

  # echo result.repr()

