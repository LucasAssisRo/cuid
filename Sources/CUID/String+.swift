extension String {
  func fitted(to length: Int, with pad: Character = "0") -> String {
    if count < length {
      String(repeating: pad, count: length - count) + self
    } else {
      String(suffix(length))
    }
  }
}
