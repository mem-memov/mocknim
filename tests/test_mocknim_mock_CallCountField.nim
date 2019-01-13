# import unittest, mocknim

# mock("mocknim/mock/callCountField")

# suite "mocknim/mock/callCountFieldy":

#   teardown:
#     unmock("mocknim/mock/callCountField")

#   test "it defines the field where the number of calls to a certain procesure is kept":

#     let
#       dependencyOriginal = mockDependencyOriginal()
#       procedureOriginal = mockProcedureOriginal()
#       signatureOriginal = mockSignatureOriginal()

#     dependencyOriginal.expects
#       .getProcedures &= ((), @[procedureOriginal])

#     procedureOriginal.expects
#       .getSignature &= ((), signatureOriginal)

#     signatureOriginal.expects
#       .getProcedureName &= ((), "someProcedureName")

#     let callCountField = newCallCountField(dependencyOriginal);

#     let result = callCountField.generate()

