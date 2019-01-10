import
  macros,
  mocknim/[
    original/dependencyOriginal
  ]


type
  DestructorMock* = ref object
    dependencyOriginal: DependencyOriginal


proc newDestructorMock*(dependencyOriginal: DependencyOriginal): DestructorMock = 

  DestructorMock(
    dependencyOriginal: dependencyOriginal
  )


proc destructMock(moduleName: string): NimNode = 

  var destructor = ("destruct" & moduleName).ident()
  var factory = ("mock" & moduleName).ident()
  var mock = "mock".ident()
  var procedure = "procedure".ident()
  var count = "count".ident()
  var calls = "calls".ident()
  var countTable = "countTable".ident()

  result = quote:

    import tables

    proc `destructor`(): void =

      var `mock` = `factory`()

      var `countTable` = initTable[string, int]()

      for `procedure`, `count` in `mock`.callCount.fieldPairs():

        `countTable`[`procedure`] = `count`

      for `procedure`, `calls` in `mock`.expects.fieldPairs():

        assert(
          `calls`.len() == `countTable`[`procedure`],
          "UNIT TEST: wrong number of calls to " & `moduleName` & "." & `procedure` & "()"
        )

      discard `factory`(true)
      

proc generate*(this: DestructorMock): NimNode =

  let moduleTypeName = this.dependencyOriginal.getModuleTypeName()

  result = destructMock(moduleTypeName)

  # echo result.repr()