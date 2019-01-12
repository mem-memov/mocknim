import
  macros,
  mocknim/[
    patch/patch
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
  var expectedParameters = "expectedParameters".ident()
  var count = "count".ident()
  var countLimit = "countLimit".ident()
  var expectedReturnValue = "expectedReturnValue".ident()

  result = quote:
    echo "call " & `moduleName` & "." & `procedureName`

    var `mock` = `factory`()
    var `count` = `mock`.callCount.`procedure`
    var `countLimit` = `mock`.expects.`procedure`.len() - 1

    if `count` <= `countLimit`:
      let `expectedParameters` = `mock`.expects.`procedure`[`count`][0]
      let `expectedReturnValue` = `mock`.expects.`procedure`[`count`][1]

      echo "insert argument check here"

      `mock`.callCount.`procedure` = `count` + 1

      return `expectedReturnValue`

    else:
      echo "UNIT TEST: unexpected call to " & `moduleName` & "." & `procedureName`



proc generate*(this: FactoryTemplate, argumentCheckNode: NimNode): NimNode =

  result = newPatch(
    mockFactory(
      this.moduleName,
      this.procedureName
    )
  )
  .insert("insert argument check here", newPatch(argumentCheckNode))
  .getTree()