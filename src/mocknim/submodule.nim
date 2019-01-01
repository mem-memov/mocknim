# This is just an example to get you started. Users of your library will
# import this file by writing ``import mocknim/submodule``. Feel free to rename or
# remove this file altogether. You may create additional modules alongside
# this file as required.

type
  Submodule* = object
    name: string


proc newSubmodule*(name: string): Submodule =
  Submodule(name: name)


proc modulate*(this: Submodule, input: string, input22: string): string = 
  result = this.name & input