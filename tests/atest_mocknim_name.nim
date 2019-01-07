import unittest, mocknim

import 
  strutils

suite "mocknim/name":

  setup:

    type
      NimNode = ref object

    proc repr(node: NimNode): string = "\"some quoted text\""

    mock("mocknim/name")

  test "it strips quote marks":

    let node = NimNode()

    let name = newName(node)

    let output = name.toString()

    check(output == "some quoted text")