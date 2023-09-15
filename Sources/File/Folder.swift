import Foundation

/// Folder functionality in PLFile
public struct Folder: FileSystem {
    public var store: Store<Folder>

    public init(store: Store<Folder>) {
        self.store = store
    }
}

extension Folder {
    /// PLFile Folder Type
    public static var type: FileType {
        return .folder
    }

    /// sequence contain all of this folder subfolder
    var subfolders: ChildSequence<Folder> {
        return store.makeChildSequence()
    }
    
    /// sequence contain all of this folder file
    var files: ChildSequence<File> {
        return store.makeChildSequence()
    }
}

extension Folder {
    /// return subfolder at a given path
    public func subfolder(at path: Path) throws -> Folder {
        return try store.subfolder(at: path)
    }
    /// create a new subfolder at a given path
    public func createSubfolder(at path: Path) throws -> Folder {
        return try store.createSubfolder(at: path)
    }
    /// create a new subfolder at a given path if need
    public func createSubfolderIfNeeded(at path: Path) throws -> Folder {
        return try (try? subfolder(at: path)) ?? createSubfolder(at: path)
    }
    /// return a file at a given path with
    public func file(at path: Path) throws -> File {
        return try store.file(at: path)
    }
    /// create a new file at a given path
    public func createFile(at path: Path, contents: Data? = nil) throws -> File {
        return try store.createFile(at: path, contents: contents)
    }
    /// create a new file at a given path if need
    public func createFileIfNeeded(at path: Path, contents: Data? = nil) throws -> File {
        return try (try? file(at: path)) ?? createFile(at: path, contents: contents)
    }
    /// Move the contents of this folder to a new parent
    public func moveContents(to folder: Folder, includeStatus: Bool = false) throws {
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
