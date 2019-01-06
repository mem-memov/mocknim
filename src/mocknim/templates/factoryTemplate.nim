import
  macros,
  mocknim/[
    templates/patch
  ]


type
  FactoryTemplate* = ref object
    moduleName: string
    procedureName: string


proc newFactoryTemplate*(moduleName: string, procedureName: string): FactoryTemplate =

  FactoryTemplate(
    moduleName: moduleName,
    procedureName: procedureName
  )

proc mockFactory(moduleName: string, procedureName: string): NimNode =

  var procedure = procedureName.ident()
  var module = moduleName.ident()
  var mock = "mock".ident()
  var factory = ("mock" & moduleName).ident()

  result = quote:

    var mock = `factory`()
    var count = mock.callCount.`procedure`
    var countLimit = mock.expects.`procedure`.len()

    if count < countLimit:
      let expectedParameters = mock.expects.`procedure`[count][0]
      let expectedReturnValue = mock.expects.`procedure`[count][1]

      mock.callCount.`procedure` = count + 1

    else:
      echo "unexpected call to " & `procedureName`

    return mock


proc generate*(this: FactoryTemplate, argumentCheckNode: NimNode): NimNode =

  result = newPatch(
    mockFactory(
      this.moduleName,
      this.procedureName
    )
  )
  .insert("insert argument check here", newPatch(argumentCheckNode))
  .tree()