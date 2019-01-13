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


proc getOriginal*(this: Module): ModuleOriginal =
  
  let file = this.directory.getFile(this.name)

  let ast = file.loadAst()

  let imports = newImports(ast, this.directory)

  let dependencies = newDependencies(imports)

  let externalDependencies = dependencies.getExternalDependencies(this.directory)

  newModuleOriginal(
    ast, 
    this.name,
    dependencies.getOriginals(),
    externalDependencies
  )
