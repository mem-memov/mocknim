import
  macros


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

  block:
    echo "---------------------------" & procedure

    var count = mock.callCount.procedureName
    var countLimit = mock.expects.procedureName.len()
    
    if count < countLimit:
      let expectedParameters = mock.expects.procedureName[count][0]
      var returnValue = mock.expects.procedureName[count][1]

      mock.callCount.procedureName = count + 1

      result = returnValue

    else:
      echo "unexpected call to " & procedure


proc generate*(this: ResultActionTemplate): NimNode =

  getAst(
    mockResultAction(
      this.moduleName.ident,
      this.procedureName.ident,
      this.procedureName,
      this.selfParameterName.ident,
      this.resultTypeName.ident
    )
  )