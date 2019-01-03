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

  let directory = Directory()

  directory.file = (name: "some_module")

  # directory.file("some_module").returns(file)
  # file.loadAst().returns(ast)
  # moduleOriginal.newModuleOriginal(ast, "some_module").returns(moduleOriginal)

  # let module = newModule("some_module", directory)
  # let output = module.original()


