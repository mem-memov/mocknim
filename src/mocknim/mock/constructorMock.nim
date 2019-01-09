import
  macros,
  sequtils,
  mocknim/[
    original/dependencyOriginal,
    mock/callCountZero,
    mock/callSequenceEmpty,
    patch/patch
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
  var reset = "reset".ident()
  var finalize = ("finalize" & moduleName).ident()

  result = quote:

    proc `factory`(`reset` = false): `module` =
      var `mock` {.global.}: `module`

      if `mock` == nil:
        new(`mock`, `finalize`)
        echo "insert assignements here"

      if `reset`:
        `mock` = nil

      return `mock`


proc generate*(this: ConstructorMock): NimNode =

  let moduleTypeName = this.dependencyOriginal.getModuleTypeName()

  let callCountZero = newCallCountZero(this.dependencyOriginal).generate()
  let callSequenceEmpty = newCallSequenceEmpty(this.dependencyOriginal).generate()

  let statements = newStmtList(callCountZero, callSequenceEmpty)

  result = newPatch(
    mockConstructor(moduleTypeName)
  )
  .insert(
    "insert assignements here", 
    newPatch(statements)
  )
  .getTree()


  # echo result.repr()



