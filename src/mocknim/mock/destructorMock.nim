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

  result = quote:

    proc `destructor`(): void =

      var `mock` = `factory`()

      for `procedure`, `count` in `mock`.callCount.fieldPairs():

        echo $`count` & "-" & `procedure`

      discard `factory`(true)
      

proc generate*(this: DestructorMock): NimNode =

  let moduleTypeName = this.dependencyOriginal.getModuleTypeName()

  return destructMock(moduleTypeName)