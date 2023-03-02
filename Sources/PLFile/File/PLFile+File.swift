import Foundation

extension PLFile {
    public struct File: FileSystem {
        public let path: Path
        
        init(_ path: Path) {
            self.path = path
        }
    }
}

/// Property
extension PLFile.File {
    public static var type: PLFileType {
        return .file
    }
}

/// Method
extension PLFile.File {
    
    public func write(_ data: Data) {
        
    }
}
