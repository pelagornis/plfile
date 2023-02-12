import Foundation

public protocol DirectoryPath: Equatable, CustomStringConvertible {
    var storage: Storage<Self> { get }
    static var directoryType: DirectoryType { get }
    init(storage: Storage<Self>)
}


public extension DirectoryPath {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.storage.path.safeRawValue == rhs.storage.path.safeRawValue
    }
    
    var description: String {
        let typeName = String(describing: type(of: self))
        return "\(typeName)(name: \(name), path: \(path))"
    }
    
    var path: Path {
        return storage.path
    }
    
    var url: URL {
        return URL(path: path.safeRawValue)
    }
    
    var name: String {
        return url.pathComponents.last!
    }
    
    init(path: Path) {
        self.init(storage: Storage(
            path: path,
            fileManager: .default
        ))
    }
}
