# PLFile
![Official](https://img.shields.io/badge/project-official-green.svg?colorA=303033&colorB=226af6&label=Pelagornis)
![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)
![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)
[![License](https://img.shields.io/github/license/pelagornis/plfile)](https://github.com/pelagornis/plfile/blob/main/LICENSE)
![Platform](https://img.shields.io/badge/platforms-iOS%2013.0%7C%20tvOS%2013.0%7C%20macOS%2010.15%7C%20watchOS%206.0-red.svg)

📁 Pelagornis File Management Library

## Installation
PLFile was deployed as Swift Package Manager. Package to install in a project. Add as a dependent item within the swift manifest.
```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/pelagornis/plfile.git", from: "1.0.8")
    ],
    ...
)
```
Then import the PLFile from thr location you want to use.

```swift
import File
```

## Documentation
The documentation for releases and ``main`` are available here:
- [``main``](https://pelagornis.github.io/plfile/main/documentation/file)


## Using

Path Setting.
```swift
let path = Path("/Users/ji-hoonahn/Desktop/") // example
```

Easy access path.
```swift
Path.current
Path.root
Path.library
Path.temporary
Path.home
Path.documents
```

Create, Write file and Folder!
```swift
let path = Path.home
let folder = try? Folder(path: path)
let file = try? folder.createFile(at: "test.swift")
try? file.write("print(1)")
```

And you can delete files and folders if you want.

```swift
try? file.delete()
try? folder.delete()
```

## License
**PLFile** is under MIT license. See the [LICENSE](LICENSE) file for more info.
