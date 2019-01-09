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
  var mock = "mock".ident()
  var procedure = "procedure".ident()
  var count = "count".ident()
  var countLimit = "countLimit".ident()
  var procedureCount = "procedureCount".ident()

  result = quote:

    proc `finalize`(`mock`: `module`) =

      echo `moduleName` & " finalized"

      for `procedure`, `count` in `mock`.callCount.fieldPairs():
        echo "111111111111111111111111" & `procedure` & "-" & $`count`

      # echo "ooo" & $`mock`.callCount.len()

      # for `procedure` in 0..`mock`.callCount.high():

      #   echo "1"
        # (`procedure`, `count`) = `procedureCount`

        # var `countLimit` = `mock`.expects.`procedure`.len()

        # assert(
        #   `count` == `countLimit`,
        #   "UNIT TEST wrong call number executed"
        # )


proc generate*(this: Finalizer): NimNode =

  let moduleTypeName = this.dependencyOriginal.getModuleTypeName()

  result = finalizeTypeMock(moduleTypeName)

  echo result.repr()



