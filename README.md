# MorphingView
Simply morph images! 💥

## Setup

Add the following to `Package.swift`:

```swift
.package(url: "https://github.com/stateman92/MorphingView", exact: .init(0, 0, 1))
```

[Or add the package in Xcode.](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

## Usage

```swift
MorphingView(animate: $animate) {
    if $0 == nil {
        return cloudImage
    }
    return $0 == cloudImage ? mapImage : cloudImage
}
```

For details see the Example app.

## Example

<p style="text-align:center;"><img src="https://github.com/stateman92/MorphingView/blob/main/Resources/screenrecording.gif?raw=true" width="50%" alt="Example"></p>
