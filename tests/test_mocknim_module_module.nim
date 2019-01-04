# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import mocknim


test "can mock module":

  mock("mocknim/module/module")

  let
    directory = mockDirectory()
    file1 = mockFile()
    dependencies1 = mockDependencies()
    imports1 = mockImports()
    moduleOriginal1 = mockModuleOriginal()


  directory.expects.file &= (("some_module"), file1)

  let ast = NimNode()
  file1.expects.loadAst &= ((), ast)

  imports1.expects.newImports &= ((ast, directory), imports1)

  dependencies1.expects.newDependencies &= ((imports1), dependencies1)

  let dependencyOriginals = @[DependencyOriginal()]
  dependencies1.expects.originals &= ((), dependencyOriginals)

  moduleOriginal1.expects.newModuleOriginal &= ((ast, "some_module", dependencyOriginals), moduleOriginal1)

  let module = newModule("some_module", directory)
  let output = module.original()



