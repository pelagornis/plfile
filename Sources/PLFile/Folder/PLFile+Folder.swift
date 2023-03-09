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
    /// PLFile Folder Type
    public static var type: PLFileType {
        return .folder
    }

    /// sequence contain all of this folder subfolder
    var subfolders: ChildSequence<PLFile.Folder> {
        return store.makeChildSequence()
    }
    
    /// sequence contain all of this folder file
    var files: ChildSequence<PLFile.File> {
        return store.makeChildSequence()
    }
}

extension PLFile.Folder {
    /// return subfolder at a given path
    public func subfolder(at path: Path) throws -> PLFile.Folder {
        return try store.subfolder(at: path)
    }
    /// create a new subfolder at a given path
    public func createSubfolder(at path: Path) throws -> PLFile.Folder {
        return try store.createSubfolder(at: path)
    }
    /// create a new subfolder at a given path if need
    public func createSubfolderIfNeeded(at path: Path) throws -> PLFile.Folder {
        return try (try? subfolder(at: path)) ?? createSubfolder(at: path)
    }
    /// return a file at a given path with
    public func file(at path: Path) throws -> PLFile.File {
        return try store.file(at: path)
    }
    /// create a new file at a given path
    public func createFile(at path: Path, contents: Data? = nil) throws -> PLFile.File {
        return try store.createFile(at: path, contents: contents)
    }
    /// create a new file at a given path if need
    public func createFileIfNeeded(at path: Path, contents: Data? = nil) throws -> PLFile.File {
        return try (try? file(at: path)) ?? createFile(at: path, contents: contents)
    }
    /// Move the contents of this folder to a new parent
    public func moveContents(to folder: PLFile.Folder, includeStatus: Bool = false) throws {
        var files = self.files
        var subfolders = subfolders
        files.includeStatus = includeStatus
        subfolders.includeStatus = includeStatus
        try files.move(to: folder)
        try subfolders.move(to: folder)
    }
    /// Empty folder, delete all of Contents
    func empty(includingStatus: Bool = false) throws {
        var files = self.files
        var subfolders = self.subfolders
        files.includeStatus = includingStatus
        subfolders.includeStatus = includingStatus
        try files.delete()
        try subfolders.delete()
    }
}
