# ``CUID``

Contains a collision-resistant identifier that sorts by creation time.

A Swift port of the JavaScript [cuid](https://github.com/ericelliott/cuid)
library.

## Usage

```swift
struct Session: Codable {
  let id: CUID
}
```

## Topics

### Identifier
- ``CUID/CUID``

### Creating an Identifier
- ``CUID/init(fingerprint:)``
- ``CUID/init(uuid:)``

### Reading the Value
- ``CUID/cuidString``
- ``CUID/rawValue``
