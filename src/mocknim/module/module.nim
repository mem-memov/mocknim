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


proc newModule*(name: string, directory: Directory): Module =

  Module(
    name: name,
    directory: directory
  )


proc original*(this: Module): ModuleOriginal =
  
  let file = this.directory.file(this.name)

  let ast = file.loadAst()

  let imports = newImports(ast, this.directory)

  let dependencies = newDependencies(imports)

  newModuleOriginal(
    ast, 
    this.name,
    dependencies.getOriginals()
  )
