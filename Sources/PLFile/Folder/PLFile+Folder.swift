import Foundation

extension PLFile {
    public struct Folder: FileSystem {
        public var store: Store<PLFile.Folder>
        
        public init(store: Store<PLFile.Folder>) {
            self.store = store
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
