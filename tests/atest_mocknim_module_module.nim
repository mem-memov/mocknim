import unittest, mocknim

suite "mocknim/module/module":

  setup:
    mock("mocknim/module/module")

  test "it wraps module AST":

    let
      directory = mockDirectory()
      file = mockFile()
      dependencies = mockDependencies()
      imports = mockImports()
      moduleOriginal = mockModuleOriginal()

    directory.expects
      .getFile &= (("some_module",), file)

    let ast = NimNode()

    file.expects
      .loadAst &= ((), ast)

    imports.expects
      .newImports &= ((ast, directory), imports)

    dependencies.expects
      .newDependencies &= ((imports,), dependencies)

    let dependencyOriginals = @[DependencyOriginal()]

    dependencies.expects
      .getOriginals &= ((), dependencyOriginals)

    moduleOriginal.expects
      .newModuleOriginal &= ((ast, "some_module", dependencyOriginals), moduleOriginal)

    let module = newModule("some_module", directory)

    let output = module.getOriginal()

    GC_fullCollect()




