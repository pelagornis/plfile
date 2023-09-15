#  Getting started

Learn how to use PLFile.

## Installation
PLFile was deployed as Swift Package Manager. Package to install in a project. Add as a dependent item within the swift manifest.
```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/pelagornis/plfile.git", from: "1.0.4")
    ],
    ...
)
```
Then import the PLFile from thr location you want to use.

```swift
import PLFile
```

## Using PLFile
PLFile offers the most commonly used Bash and ZSH, which in addition helps users scale easily.

Path Setting.

```swift
let path = Path("/Users/pelagornis/Desktop/") // example
```
Easy access Path.
```swift
Path.root
Path.home
Path.current
Path.temporary
```
Easily create files and folders

```swift
let path = Path.home
let folder = try! PLFile.Folder(path: path)
let file = try! folder.createFile(at: "test.swift")
try! file.write("print(1)")
```

Easy and quick delete files and folders.
``` swift
try! file.delete()
try! folder.delete()
```