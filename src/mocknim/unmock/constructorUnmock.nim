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

  var destructor = ("destruct" & moduleName).ident()

  result = quote:

    `destructor`()


proc generate*(this: ConstructorUnmock): NimNode =

  let moduleTypeName = this.dependencyOriginal.getModuleTypeName()

  result = mockConstructor(moduleTypeName)

  # echo result.repr()