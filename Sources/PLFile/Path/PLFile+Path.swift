import Foundation

/// Manage the path of the PLFile.
public struct Path {
    /// root path
    public static let root = Path("/")
    
    /// home path
    public static var home = Path("~")
    
    /// standardized path
    public var standardized: Path {
        return Path((self.rawValue as NSString).standardizingPath)
    }
    
    /// resolving all symlinks path
    public var resolved: Path {
        return Path((self.rawValue as NSString).resolvingSymlinksInPath)
    }
    
    /// fileName finding
    public var fileName: String {
        return self.absolutePath.pathComponent.last?.rawValue ?? ""
    }
    
    /// absolute path
    public var absolutePath: Path {
        if rawValue.hasPrefix("/") {
            return self.standardized
        } else {
            return Path(Path.current.rawValue + self.rawValue).standardized
        }
    }
    
    /// parent path
    public var parents: Path {
        if rawValue.hasPrefix("/") {
            return Path((absolutePath.rawValue as NSString).deletingLastPathComponent)
        } else {
            let component = pathComponent
            if component.isEmpty {
                return Path("..")
            } else if component.last?.rawValue == ".." {
                return Path(".." + self[component.count - 1].rawValue)
            } else if pathComponent.count == 1 {
                return Path("")
            } else {
                return self[component.count - 2]
            }
        }
    }
    
    /// path component
    public var pathComponent: [Path] {
        if rawValue.isEmpty || rawValue == "." { return .init() }
        if rawValue.hasPrefix("/") {
            return (absolutePath.rawValue as NSString).pathComponents.enumerated().compactMap {
                (($0 == 0 || $1 != "/") && $1 != ".") ? Path($1) : nil
            }
        } else {
            let component = (self.rawValue as NSString).pathComponents.enumerated()
            let safeComponent = component.compactMap {
                (($0 == 0 || $1 != "/") && $1 != ".") ? Path($1) : nil
            }
            return safeComponents(safeComponent)
        }
    }
    
    /// current path
    public static var current: Path {
        get {
            return Path(FileManager.default.currentDirectoryPath)
        } set {
            FileManager.default.changeCurrentDirectoryPath(newValue.safeRawValue)
        }
    }
    
    /// stored Path String value
    public var rawValue: String
    
    /// Safe Raw Value with Path
    var safeRawValue: String {
        return rawValue.isEmpty ? "." : rawValue
    }
    
    /// resolving path '..'
    fileprivate func safeComponents(_ component: [Path]) -> [Path] {
        var result = false
        let count = component.count
        let safecomponent: [Path] = component.enumerated().compactMap {
            if ($1.rawValue != ".." && component[$0 + 1].rawValue == ".." && $0 < count - 1) ||
                ($1.rawValue == ".." && component[$0 - 1].rawValue != ".." && $0 > 0) {
                result = true
                return nil
            } else {
                return $1
            }
        }
        return result ? safeComponents(safecomponent) : safecomponent
    }
    
    /// Initalizer
    public init() {
        self = .root
    }
    
    /// Initalizer with swift path
    public init(_ path: String, _ fileManager: FileManager = .default) {
        self.rawValue = path
    }
}

extension Path {
    
    /// Path Subscript
    public subscript(_ position: Int) -> Path {
        let component = pathComponent
        if position >= component.count || position < 0 {
            fatalError("Path index out of range")
        } else {
            var result = component.first!
            for index in 1..<position + 1 {
                result = Path(result.rawValue + component[index].rawValue)
            }
            return result
        }
    }
    
    public subscript(_ bounds: Range<Int>) -> Path {
        let component = self.pathComponent
        if bounds.upperBound >= component.count || bounds.lowerBound < 0 {
            fatalError("Path bounds out of range")
        }
        var result = component[bounds.lowerBound]
        for index in (bounds.lowerBound + 1)..<(bounds.upperBound) {
            result  = Path(result.rawValue + component[index].rawValue)
        }
        return result
    }
    
}
