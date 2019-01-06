import unittest, mocknim

import 
  macros, 
  strutils

suite "mocknim/name":

  setup:
    mock("mocknim/name")

  test "it strips quote marks":

    let node = NimNode()

    let name = newName(node)