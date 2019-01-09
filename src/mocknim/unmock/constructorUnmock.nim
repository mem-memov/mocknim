import
  macros,
  mocknim/[
    original/dependencyOriginal
  ]


type
  ConstructorUnmock* = ref object
    dependencyOriginal: DependencyOriginal


proc newConstructorUnmock*(dependencyOriginal: DependencyOriginal): ConstructorUnmock = 

  ConstructorUnmock(
    dependencyOriginal: dependencyOriginal
  )


proc mockConstructor(moduleName: string): NimNode =

  var mock = "mock".ident()
  var factory = ("mock" & moduleName).ident()
  var procedure = "procedure".ident()
  var count = "count".ident()

  result = quote:

    var mock = `factory`(true)

    for `procedure`, `count` in mock.callCount.fieldPairs():

      echo "-" & `procedure`


proc generate*(this: ConstructorUnmock): NimNode =

  let moduleTypeName = this.dependencyOriginal.getModuleTypeName()

  result = mockConstructor(moduleTypeName)

  # echo result.repr()