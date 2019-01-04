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

  # let imports = mockImports()
  # imports.expects.files &= ((), @[file])
  # directory.expects.removeMeIAmForTesting &= ((), ())
  # # directory.expects.file &= ((), ())
  # # directory.expects.file &= ((), file)
  # # directory.expects.file &= ((name: "some_module"), ()))
  directory.expects.file &= (("some_module"), file1)



  let module = newModule("some_module", directory)
  let output = module.original()

  
  # echo mockDirectory().repr()






