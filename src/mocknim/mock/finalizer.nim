import 
  macros,
  mocknim/[
    original/dependencyOriginal
  ]

type
  Finalizer* = ref object
    dependencyOriginal: DependencyOriginal

proc newFinalizer*(dependencyOriginal: DependencyOriginal): Finalizer =

  Finalizer(
    dependencyOriginal: dependencyOriginal
  )


proc finalizeTypeMock(moduleName: string): Nimnode =

  var finalize = ("finalize" & moduleName).ident()
  var module = moduleName.ident()

  result = quote:

    proc `finalize`(o: `module`) =

      echo `moduleName` & " finalized"


proc generate*(this: Finalizer): NimNode =

  let moduleTypeName = this.dependencyOriginal.getModuleTypeName()

  result = finalizeTypeMock(moduleTypeName)



