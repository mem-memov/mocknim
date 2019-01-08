# mocknim

A tool for creating mocks. Current goal is that it should mock its own modules. So the package seems to be self-explanatory. 

If you should choose to compose your modules like it is done here, you can count on this package to provide you with mocks needed. The requirements are as follows:

* one type is declared in each module file with the name of the file (first letter is upper case)
* one or many constructor procedures are present which return a single object of the type
* other procedures must have the first parameter of type that is declared in the module
* there may be other types and proceduders so long as they are not visible outside of the module

[Example](src/mocknim/name.nim)

Install Nim, install Nimble and

```
https://github.com/mem-memov/mocknim
cd mocknim
nimble test
```

Test files in the **tests** directory must be named with the lower letter **t** at the front. As the recursive directory traversal is missing in the current **nimble test** implementation one of possible naming strategies could be:

* start with **test_**
* add each subfolger as **subfolder_**
* finish with module file name **myModule.nim**

The file name may look like this: **test_myPackage_subfolder_myModule.nim**

In test file the following sections are not unusual:

```nim
import unittest, mocknim

# generate all types and procedures needed to test this module
mock("MyPackage/subfolder/myModule")

suite "MyPackage/subfolder/myModule": # the suite name is arbitrary

  teardown:
    # reset mocks after each test and check number of procedure calls in the test
    unmock("MyPackage/subfolder/myModule")

  test "it can do something":

    # create mock objects that are used inside procedure under test
    let
      myDependency = mockMyDependency()

    # provide for execution flow of procedure under test

    myDependency.expects
      .doSomeThingWithTheDataAndReturn &= (("my data",), "my_result")

    # create real object

    let myModule = newMyModule(myDependency)

    # execute procedure under test

    let output = myModule.doSomeProcessing()

    # check the output with the means of "nim unittest"
    
```


[Nim Unittest](https://nim-lang.org/docs/unittest.html)

State is stored in a structure of the type that is defined in the module file.

Procedurs

* Constructor

It takes some or none arguments and returns one structure carrying the state.

```nim
var a = mockA()
a.expects.newA &= ((), a)
```

* Action

It has at least one argument. Its first argument is always of the state type. This is to comply with Uniform Function Call Syntax (UFCS). Other arguments may or may not be passed to it. It may return one or no result. Types of the arguments and the result may be chosen at will. When you specify which procedure calls you expect to be executed wenn your test runs, you should omit the fist argument that keeps the state.

```nim
var a = mockA()
var b = mockB()
a.expects.doWithout &= ((), ())
a.expects.doWithOne &= ((arg,), ())
a.expects.doWithoutAndReturn &= ((), b)
a.expects.doWithTwoAndReturn &= ((arg_1, arg_2), b))
```

Limitations

Automatically are mocked only modules which can be loaded from actual files of the project. 