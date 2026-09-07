import Foundation

extension String {
  func filled(to length: Int) -> String {
    padding(toLength: length, withPad: "0", startingAt: 0)
  }
}
