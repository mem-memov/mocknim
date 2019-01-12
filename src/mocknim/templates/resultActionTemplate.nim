import
  macros,
  mocknim/[
    patch/patch
  ]


type
  ResultActionTemplate* = ref object
    moduleName: string
    procedureName: string
    selfParameterName: string


proc newResultActionTemplate*(
    moduleName: string,
    procedureName: string, 
    selfParameterName: string): ResultActionTemplate =

  ResultActionTemplate(
    moduleName: moduleName,
    procedureName: procedureName,
    selfParameterName: selfParameterName
  )


proc mockResultAction(
  moduleName: string,
  procedureName: string,
  selfParameterName: string): NimNode =

  var procedure = procedureName.ident()
  var mock = selfParameterName.ident()
  var count = "count".ident()
  var countLimit = "countLimit".ident()
  var expectedParameters = "expectedParameters".ident()
  var returnValue = "returnValue".ident()

  result = quote:
    echo "call " & `moduleName` & "." & `procedureName`

    var `count` = `mock`.callCount.`procedure`
    var `countLimit` = `mock`.expects.`procedure`.len() - 1

    if `count` <= `countLimit`:
      let `expectedParameters` = `mock`.expects.`procedure`[`count`][0]
      var `returnValue` = `mock`.expects.`procedure`[`count`][1]

      echo "insert argument check here"

      `mock`.callCount.`procedure` = `count` + 1

      return `returnValue`

    else:
      echo "\nUNIT TEST: unexpected call to " & `moduleName` & "." & `procedureName` & "\n"


proc generate*(this: ResultActionTemplate, argumentCheckNode: NimNode): NimNode =

  result = newPatch(
    mockResultAction(
      this.moduleName,
      this.procedureName,
      this.selfParameterName
    )
  )
  .insert("insert argument check here", newPatch(argumentCheckNode))
  .getTree()

  # echo result.repr()

