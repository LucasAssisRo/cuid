@testable import CUID
import Testing

private struct `String filling tests` {
  @Test(arguments: [
    (value: "1", length: 4, expected: "0001"),
    (value: "z9", length: 4, expected: "00z9"),
    (value: "", length: 3, expected: "000"),
  ]) func `grows small string`(testCase: (value: String, length: Int, expected: String)) {
    #expect(testCase.value.fitted(to: testCase.length) == testCase.expected)
  }

  @Test(arguments: [
    (value: "255t", length: 2, expected: "5t"),
    (value: "1rc", length: 2, expected: "rc"),
  ]) func `shrinks long string`(testCase: (value: String, length: Int, expected: String)) {
    #expect(testCase.value.fitted(to: testCase.length) == testCase.expected)
  }

  @Test private func `leaves a string of the requested length alone`() {
    #expect("abcd".fitted(to: 4) == "abcd")
  }

  @Test(arguments: [
    (pad: Character("x"), expected: "xx7"),
    (pad: Character(" "), expected: "  7"),
  ]) func `pads with the given character`(testCase: (pad: Character, expected: String)) {
    #expect("7".fitted(to: 3, with: testCase.pad) == testCase.expected)
  }
}
