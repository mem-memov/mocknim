import unittest, mocknim

suite "mocknim/factory":

  setup:
    mock("mocknim/factory")

  test "it creates module mock generator":

    let
      directory = mockDirectory()
      name = mockName()
      module = mockModule()
      moduleMock = mockModuleMock()

    let moduleNode = NimNode()

    name.expects
      .newName &= ((moduleNode,), name)

    directory.expects
      .newDirectory &= (("./src",), directory)

    name.expects
      .toString &= ((), "myModule")

    module.expects
      .newModule &= (("myModule", directory), module)

    let moduleOriginal = ModuleOriginal()

    module.expects
      .getOriginal &= ((), moduleOriginal)

    moduleMock.expects
      .newModuleMock &= ((moduleOriginal,), moduleMock)

    let factory = newFactory()

    let output = factory.makeMock(moduleNode)

    check(output == moduleMock)