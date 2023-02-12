import Foundation

public extension PLFile {
    struct File: DirectoryPath {
        public static var directoryType: DirectoryType {
            return .file
        }

        public let storage: Storage<PLFile.File>

        public init(storage: Storage<PLFile.File>) {
            self.storage = storage
        }
    }
    struct Folder: DirectoryPath {
        public static var directoryType: DirectoryType {
            return .folder
        }

        public let storage: Storage<PLFile.Folder>

        public init(storage: Storage<PLFile.Folder>) {
            self.storage = storage
        }
    }
}
