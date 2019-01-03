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

  let file = mockFile()

  # # directory.file &= (_, _)
  # # directory.file &= (_, file)
  # # directory.file &= ((name: "some_module"), _)
  directory.file &= (("secret_file"), file)
  directory.file &= (("public_file"), file)



  # let module = newModule("some_module", directory)
  # let output = module.original()

  
  # echo mockDirectory().repr()






