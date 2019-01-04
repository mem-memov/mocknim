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

  let directory = mockDirectory()
  let file1 = mockFile()
  let dependencies1 = mockDependencies()


  directory.expects.file &= (("some_module"), file1)

  let ast = NimNode()
  file1.expects.loadAst &= ((), ast)

  dependencies1.expects.originals &= ((), @[DependencyOriginal()])


  let module = newModule("some_module", directory)
  let output = module.original()




