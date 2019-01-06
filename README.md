# mocknim

A tool for creating mocks. Current goal is that is should mock own modules. So the package seems to be self-explanatory. 

If you should choose to compose your modules like it is done here, you can count on this package to provide you with mocks needed. The requirements are as follows:

* one type is declared in each module file with the name of the file (fires letter is upper case)
* one or many constructor procedures are present which return a single object of the type
* other procedures must have the first parameter of type that is declared in the module
* there may be other types and proceduders so long as they are not visible outside of the module

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

suite "MyPackage/subfolder/myModule": # the suite name is arbitrary

  # generate all types and procedures needed to test this module
  mock("MyPackage/subfolder/myModule")

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

    # check the output with the means of "nimble test"
    
```