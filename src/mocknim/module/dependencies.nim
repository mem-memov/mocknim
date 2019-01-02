import 
  macros,
  mocknim/[
    module/file,
    module/imports,
    original/dependencyOriginals
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

  for file in files:

    if file.exists():

      let ast = file.loadAst()

      echo ast.treeRepr()

  DependencyOriginals()