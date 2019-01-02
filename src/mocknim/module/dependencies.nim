import 
  macros,
  mocknim/[
    module/file,
    module/imports,
    original/dependencyOriginals,
    original/dependencyOriginal
  ]


type
  Dependencies* = ref object
    imports: Imports


proc newDependencies*(imports: Imports): Dependencies =

  Dependencies(
    imports: imports
  )


proc original*(this: Dependencies): DependencyOriginals =

  let files = this.imports.files()

  var list: seq[DependencyOriginal] = @[]

  for file in files:

    if file.exists():

      let ast = file.loadAst()

      list.add(
        newDependencyOriginal(ast, file.moduleTypeName())
      )

  result = newDependencyOriginals(list)