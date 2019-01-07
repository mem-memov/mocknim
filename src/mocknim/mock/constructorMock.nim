import
  macros,
  mocknim/[
    original/dependencyOriginal,
    mock/callCountZero
  ]


type
  ConstructorMock* = ref object
    dependencyOriginal: DependencyOriginal


proc newConstructorMock*(dependencyOriginal: DependencyOriginal): ConstructorMock = 

  ConstructorMock(
    dependencyOriginal: dependencyOriginal
  )

proc mockConstructor(moduleName: string): NimNode =

  var module = moduleName.ident()
  var factory = ("mock" & moduleName).ident()

  result = quote:

    proc `factory`(): `module` =
      var mock {.global.} = `module`()
      return mock


proc generate*(this: ConstructorMock): NimNode =

  let moduleTypeName = this.dependencyOriginal.getModuleTypeName()

  let callCountZero = newCallCountZero(this.dependencyOriginal).generate()

  result = mockConstructor(moduleTypeName)

  result[6][0][0][2] = callCountZero

  echo result.repr()

  # dumpAstGen:
  #   proc mockDirectory(): Directory =
  #     var mock {.global.} = Directory(
  #       callCount: (
  #         getFiles: 0
  #       )
  #     )
  #     result = mock


