import
  macros,
  mocknim/[
    templates/patch
  ]


type
  ResultActionTemplate* = ref object
    moduleName: string
    procedureName: string
    selfParameterName: string
    resultTypeName: string


proc newResultActionTemplate*(
  moduleName: string, 
  procedureName: string,
  selfParameterName: string,
  resultTypeName: string): ResultActionTemplate =

  ResultActionTemplate(
    moduleName: moduleName,
    procedureName: procedureName,
    selfParameterName: selfParameterName,
    resultTypeName: resultTypeName
  )


proc mockResultAction(
  procedureName: string,
  selfParameterName: string): NimNode =

  var procedure = procedureName.ident()
  var mock = selfParameterName.ident()

  result = quote:
    echo "---------------------------" & `procedureName`

    var count = `mock`.callCount.`procedure`
    var countLimit = `mock`.expects.`procedure`.len()

    if count < countLimit:
      let expectedParameters = `mock`.expects.`procedure`[count][0]
      var returnValue = `mock`.expects.`procedure`[count][1]

      # echo "insert argument check here"

      `mock`.callCount.`procedure` = count + 1

      return returnValue

    else:
      echo "unexpected call to " & `procedureName`


proc generate*(this: ResultActionTemplate, argumentCheckNode: NimNode): NimNode =

  result = newPatch(
    mockResultAction(
      this.procedureName,
      this.selfParameterName
    )
  )
  .insert("insert argument check here", newPatch(argumentCheckNode))
  .tree()

