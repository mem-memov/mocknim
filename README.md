# mocknim

A tool for creating mocks. Current goal is that is should mock own modules. So the package seems to be self-explanatory. 

If you should choose to compose your modules like it is done here, you can count on this package to provide you with mocks needed.

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

suite "MyPackage/subfolder/myModule":

  # generate all types and procedures needed to test this module
  mock("MyPackage/subfolder/myModule")

  test "it can do something":

    # create mock objects that are used inside procedure under test
    let
      myDependency = mockMyDependency()
```