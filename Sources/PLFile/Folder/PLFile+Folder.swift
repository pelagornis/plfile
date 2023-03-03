import Foundation

extension PLFile {
    public struct Folder: FileSystem {
        public let path: Path
        
        init(_ path: Path) {
            self.path = path
        }
    }
}

extension PLFile.Folder {
    public static var type: PLFileType {
        return .folder
    }
}

extension PLFile.Folder {

}
