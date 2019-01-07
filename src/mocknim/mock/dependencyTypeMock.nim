import
  macros,
  mocknim/[
    original/dependencyOriginal,
    mock/callCountField,
    mock/callSequenceField
  ]


type
  DependencyTypeMock* = ref object
    dependencyOriginal: DependencyOriginal


proc newDependencyTypeMock*(dependencyOriginal: DependencyOriginal): DependencyTypeMock =

  DependencyTypeMock(
    dependencyOriginal: dependencyOriginal
  )


proc generate*(this: DependencyTypeMock): NimNode =

  var moduleTypeFields = nnkRecList.newTree()

  let callCountField = newCallCountField(this.dependencyOriginal)
  moduleTypeFields.add(callCountField.generate())

  let callSequenceField = newCallSequenceField(this.dependencyOriginal)
  moduleTypeFields.add(callSequenceField.generate())

  let moduleTypeName = this.dependencyOriginal.getModuleTypeName()

  result = nnkTypeDef.newTree(
    newIdentNode(moduleTypeName),  # <---
    newEmptyNode(),
    nnkRefTy.newTree(
      nnkObjectTy.newTree(
        newEmptyNode(),
        newEmptyNode(),
        moduleTypeFields, # <---
      )
    )
  )

  # echo result.repr()

  # dumpAstGen:
  #   type
  #     Directory = ref object
  #       callCount: tuple[newDirectory: int]
  #       expects: tuple[
  #         newDirectory: seq[
  #           (
  #             (string,), 
  #             File
  #           )
  #         ]
  #       ]


