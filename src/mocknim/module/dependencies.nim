import 
  macros,
  mocknim/[
    module/file,
    module/imports,
    original/dependencyOriginal
  ]


type
  Dependencies* = ref object
    imports: Imports


proc newDependencies*(imports: Imports): Dependencies =

  Dependencies(
    imports: imports
  )


proc getOriginals*(this: Dependencies): seq[DependencyOriginal] =

  let files = this.imports.getFiles()

  for file in files:

    if file.exists():

      let ast = file.loadAst()

      result.add(
        newDependencyOriginal(ast, file.getModuleTypeName())
      )