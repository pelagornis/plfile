import Foundation

/// Manage the path of the PLFile.
public struct Path {
    
    /// root path
    public static let root = Path("/")
    
    /// current path
    public static var current: Path {
        get {
            return Path(FileManager.default.currentDirectoryPath)
        } set {
            
        }
    }
    
    public init(_ path: String) {
    }
}
