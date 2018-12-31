import macros, strutils

# proc walkAst

macro mock*(module: string, procedure: string): untyped =
  result = newStmtList()

  let moduleName = module.repr().strip(true, true, {'"'})
  let procedureName = procedure.repr().strip(true, true, {'"'})

  let path = "../src/" & moduleName & ".nim"
  let file = staticRead(path)
  let ast = parseStmt(file)

  for node in ast:
    if node.kind == nnkProcDef:
      let nodeProcedureName = node[0][1].repr()
      if nodeProcedureName == procedureName:
        echo node.treeRepr()
        let resultType = node[3][0].repr()
        for i, argument in node[3]:
          if i == 0:
            continue
          let argumentName = argument[1].repr
          let argumentType = argument[0].repr
          echo argumentType
          # echo argument.treeRepr()

