# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import mocknim

test "can mock class constructor":

  echo "not ready yet"
  # mock("mocknim/submodule", "newSubmodule")

  # newSubmodule("sub")


test "can mock class method":

  mock("mocknim/submodule", "modulate")

  let a = Submodule(input: "aga", input22: "ogo", result: "aga-ogo")

  let output = a.modulate("aga", "ogo")

  assert("aga-ogo" == output) 

