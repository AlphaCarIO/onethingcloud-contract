module.exports = {
  expectThrow: async promise => {
    try {
      await promise
    } catch (error) {
      //console.log("err_msg:", error.message)
      const invalidJump = error.message.search('invalid JUMP') >= 0
      const invalidOpcode = error.message.search('invalid opcode') >= 0
      const outOfGas = error.message.search('out of gas') >= 0
      const revert = error.message.search('transaction: revert') >= 0
      //console.log(invalidJump, invalidOpcode, outOfGas, revert);
      assert(invalidJump || invalidOpcode || outOfGas || revert, "Expected throw, got '" + error + "' instead")
      return
    }
    assert.fail('Expected throw not received')
  },
  expectThrow2: async (promise, errMsg) => {
    try {
      await promise
    } catch (error) {
      //console.log("err_msg:", error.message)
      const is_exist = error.message.search(errMsg) >= 0
      assert(is_exist, "It is an unexpected throw, got '" + error.message + "' instead")
      return
    }
    assert.fail('Expected throw2 not received')
  }
}
