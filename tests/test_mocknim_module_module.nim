import unittest, mocknim
suite "mocknim/module/module":

  setup:
  
    # generate all types and procedures needed to test this module
    mock("mocknim/module/module")

  test "it wraps module AST":

    # create mock objects that are used inside procedure under test
    let
      directory = mockDirectory()
      file1 = mockFile()
      dependencies1 = mockDependencies()
      imports1 = mockImports()
      moduleOriginal1 = mockModuleOriginal()

    # provide for execution flow of procedure under test

    directory.expects.file &= 
      (("some_module"), file1)

    let ast = NimNode()
    file1.expects.loadAst &= 
      ((), ast)

    imports1.expects.newImports &= 
      ((ast, directory), imports1)

    dependencies1.expects.newDependencies &= 
      ((imports1), dependencies1)

    let dependencyOriginals = @[DependencyOriginal()]
    dependencies1.expects.originals &=
      ((), dependencyOriginals)

    moduleOriginal1.expects.newModuleOriginal &= 
      ((ast, "some_module", dependencyOriginals), moduleOriginal1)

    # create real object

    let module = newModule("some_module", directory)
    module.name = "some_module"

    # execute procedure under test

    let output = module.original()




