import
  macros,
  mocknim/[
    original/dependencyOriginal,
    mock/callCountZero,
    mock/callSequenceEmpty
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
  var mock = "mock".ident()

  result = quote:

    proc `factory`(): `module` =
      var `mock` {.global.}: `module`
      if `mock` == nil:
        `mock` = `module`()
        new(`mock`)
      return `mock`


proc generate*(this: ConstructorMock): NimNode =

  let moduleTypeName = this.dependencyOriginal.getModuleTypeName()

  let callCountZero = newCallCountZero(this.dependencyOriginal).generate()
  let callSequenceEmpty = newCallSequenceEmpty(this.dependencyOriginal).generate()

  result = mockConstructor(moduleTypeName)

  result[6][1][0][1][0][1] = nnkObjConstr.newTree(
    newIdentNode(moduleTypeName),
    callCountZero,
    callSequenceEmpty
  )

  # echo result.repr()

  # dumpAstGen:
  #   proc mockDirectory(): Directory =
  #     var mock {.global.} = Directory(
  #       callCount: (
  #         getFiles: 0
  #       )
  #     )
  #     result = mock


