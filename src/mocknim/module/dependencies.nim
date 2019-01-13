import 
  macros,
  sequtils,
  mocknim/[
    module/file,
    module/imports,
    module/directory,
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

proc getExternalDependencies*(this: Dependencies, directory: Directory): seq[string] = 

  let files = this.imports.getFiles()

  for file in files:

    if not file.exists():

      result.add(file.getModuleName())

    else:

      let ast = file.loadAst()
      let imports = newImports(ast, directory)
      let subfiles = imports.getFiles()

      for subfile in subfiles:

        if not subfile.exists():

          result.add(subfile.getModuleName())

  result = result.deduplicate()