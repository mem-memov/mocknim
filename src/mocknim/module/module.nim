import 
  macros,
  mocknim/[
    module/directory,
    module/file,
    module/dependencies,
    module/imports,
    original/moduleOriginal
  ]


type
  Module* = ref object
    name: string
    directory: Directory
    dependencies: Dependencies


proc newModule*(name: string, directory: Directory, dependencies: Dependencies): Module =

  Module(
    name: name,
    directory: directory,
    dependencies: dependencies
  )


proc original*(this: Module): ModuleOriginal =
  
  let file = this.directory.file(this.name)

  let ast = file.loadAst()

  let imports = newImports(ast)

  newModuleOriginal(
    ast, 
    this.name,
    this.dependencies.original(
      imports.files()
    )
  )
