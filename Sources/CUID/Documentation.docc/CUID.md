# ``CUID``

Generate collision-resistant identifiers that sort by creation time.

## Overview

A CUID is a short, URL-safe string built from a timestamp, a rolling counter, a
client fingerprint and a random block. Because the timestamp leads, identifiers
sort in the order they were created — useful as a database key, where random
`UUID`s scatter writes across an index.

```swift
let id = CUID(fingerprint: deviceId.uuidString)
print(id) // c1x2k3f8a00003b6mfx1abcd2
```

The fingerprint separates identifiers generated on different devices at the
same moment, so it should be stable for the installation rather than fresh each
launch. Pass a `UUID` directly when you have one:

```swift
let id = CUID(uuid: UIDevice.current.identifierForVendor!)
```

This is a Swift port of the JavaScript
[cuid](https://github.com/ericelliott/cuid) library.

## Topics

### Identifiers

- ``CUID/CUID``
