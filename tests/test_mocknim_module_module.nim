import unittest, mocknim
suite "mocknim/module/module":

  setup:
  
    # generate all types and procedures needed to test this module
    mock("mocknim/module/module")

  test "it wraps module AST":

    # create mock objects that are used inside procedure under test
    let
      directory = mockDirectory()
      file = mockFile()
      dependencies = mockDependencies()
      imports = mockImports()
      moduleOriginal = mockModuleOriginal()

    # provide for execution flow of procedure under test

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

    # create real object

    let module = newModule("some_module", directory)

    # execute procedure under test

    let output = module.getOriginal()




