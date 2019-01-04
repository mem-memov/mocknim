import
  macros


type
  FactoryTemplate* = ref object
    moduleName: string
    procedureName: string


proc newFactoryTemplate*(moduleName: string, procedureName: string): FactoryTemplate =

  FactoryTemplate(
    moduleName: moduleName,
    procedureName: procedureName
  )

template mockFactory(moduleName: untyped, procedureName: untyped, procedure: string): untyped =

  block:
    echo "---------------------------" & procedure
    var mock = `mock moduleName`()
    var count = mock.callCount.procedureName
    var countLimit = mock.expects.procedureName.len()

    if count < countLimit:
      let expectedParameters = mock.expects.procedureName[count][0]
      let expectedReturnValue = mock.expects.procedureName[count][1]

      mock.callCount.procedureName = count + 1

    else:
      echo "unexpected call to " & procedure

    result = mock

proc generate*(this: FactoryTemplate): NimNode =

  getAst(
    mockFactory(
      this.moduleName.ident,
      this.procedureName.ident,
      this.procedureName
    )
  )