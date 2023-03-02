import Foundation

public protocol FileSystem: Equatable, CustomStringConvertible {
    static var type: PLFileType { get }
    var path: Path { get }
}

public extension FileSystem {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.description == rhs.description
    }
    
    var description: String {
        return "(name: \(name), path: \(path.rawValue))"
    }
    
    var url: URL {
        return URL(fileURLWithPath: path.rawValue)
    }
    
    var name: String {
        return url.pathComponents.last!
    }
}

public extension FileSystem {
    func rename(to newName: String, keepExtensions: Bool = true) throws {
        
    }
}
