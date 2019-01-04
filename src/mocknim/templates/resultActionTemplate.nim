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


template mockResultAction(
  moduleName: untyped, 
  procedureName: untyped, 
  procedure: string, 
  mock: untyped,
  returnType: untyped): untyped =

  echo "---------------------------" & procedure

  var count = mock.callCount.procedureName
  var countLimit = mock.expects.procedureName.len()
  
  if count < countLimit:
    let expectedParameters = mock.expects.procedureName[count][0]
    var returnValue = mock.expects.procedureName[count][1]

    result = returnValue

    echo "insert argument check here"

    mock.callCount.procedureName = count + 1

  else:
    echo "unexpected call to " & procedure


proc generate*(this: ResultActionTemplate, argumentCheckNode: NimNode): NimNode =

  result = newPatch(
    getAst(
      mockResultAction(
        this.moduleName.ident,
        this.procedureName.ident,
        this.procedureName,
        this.selfParameterName.ident,
        this.resultTypeName.ident
      )
    )
  )
  .insert("insert argument check here", newPatch(argumentCheckNode))
  .tree()
