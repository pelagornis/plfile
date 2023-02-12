import Foundation

public struct Path {
    public static let separator = "/"
    
    public static let root = Path(separator)
    public static var current: Path {
        get {
            return Path(FileManager.default.currentDirectoryPath)
        }
        set {
            FileManager.default.changeCurrentDirectoryPath(newValue.safeRawValue)
        }
    }
    
    public  var rawValue: String
    
    var safeRawValue: String {
        return rawValue.isEmpty ? "." : rawValue
    }
    
    public init() {
        self = .root
    }
    
    public init(_ path: String) {
        self.rawValue = path
    }
}
