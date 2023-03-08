import Foundation

public final class Store<fileSystem: FileSystem> {
    var path: Path
    private let fileManager: FileManager
    
    init(path: Path, fileManager: FileManager) throws {
        self.path = path
        self.fileManager = fileManager
        try translatePath()
    }
    
    var attributes: [FileAttributeKey : Any] {
        return (try? fileManager.attributesOfItem(atPath: path.rawValue)) ?? [:]
    }
}

extension Store {
    /// move FileSystem
    func move(to newPath: String) throws {
        do {
            try fileManager.moveItem(atPath: path.rawValue, toPath: newPath)
            switch fileSystem.type {
            case .file:
                path.rawValue = newPath
            case .folder:
                path.rawValue = newPath.appendSafeSuffix("/")
            }
        } catch {
            throw PLFileError.moveError(path: path, error: error)
        }
    }
    /// copy FileSystem
    func copy(to newPath: String) throws {
        do {
            try fileManager.copyItem(atPath: path.rawValue, toPath: newPath)
        } catch {
            throw PLFileError.copyError(path: path, error: error)
        }
    }
    /// delete FileSystem
    func delete() throws {
        do {
            try fileManager.removeItem(atPath: path.rawValue)
        } catch {
            throw PLFileError.deleteError(path: path, error: error)
        }
    }
    
    /// path translate
    private func translatePath() throws {
        switch fileSystem.type {
        case .file:
            try storeFileEmpty()
        case .folder:
            try storeFolderEmpty()
        }
        if path.rawValue.hasPrefix("~") {
            let home = ProcessInfo.processInfo.environment["HOME"]!
            path.rawValue = home + path.rawValue.dropFirst()
        }
        
        while let parentRange = path.rawValue.range(of: "../") {
            let folderPath = path.rawValue[..<parentRange.lowerBound]
            let parentsPath = Path(String(folderPath)).parents
            try filesystemExists()
            
            path.rawValue.replaceSubrange(..<parentRange.upperBound, with: parentsPath.rawValue)
        }
        try filesystemExists()
        
    }
    
    private func storeFileEmpty() throws {
        if path.rawValue.isEmpty {
            throw PLFileError.filePathEmpty(path: path)
        }
    }
    
    private func storeFolderEmpty() throws {
        if path.rawValue.isEmpty {
            path = Path(fileManager.currentDirectoryPath)
        }
        if !path.rawValue.hasPrefix("/") {
            path.rawValue += "/"
        }
    }
    
    private func filesystemExists() throws {
        var isFolder: ObjCBool = false
        var fileSystemStatus: Bool = false
        
        if !fileManager.fileExists(atPath: path.rawValue, isDirectory: &isFolder) {
            fileSystemStatus = false
        }
        
        switch fileSystem.type {
        case .file:
            fileSystemStatus = !isFolder.boolValue
        case .folder:
            fileSystemStatus = isFolder.boolValue
        }
        
        guard fileSystemStatus else {
            throw PLFileError.missing(path: path)
        }
    }
}

extension Store where fileSystem == PLFile.Folder {
    /// make Child Sequence
    func makeChildSequence<T: FileSystem>() -> PLFile.Folder.ChildSequence<T> {
        return PLFile.Folder.ChildSequence(
            folder: PLFile.Folder(store: self),
            fileManager: fileManager,
            recursive: false,
            includeStatus: false
        )
    }
    
    /// subfolder information
    func subfolder(at folderPath: Path) throws -> PLFile.Folder {
        let folderPath = path.rawValue + folderPath.rawValue.removeSafePrefix("/")
        let store = try Store(path: Path(folderPath), fileManager: fileManager)
        return PLFile.Folder(store: store)
    }
    /// file information
    func file(at filePath: Path) throws -> PLFile.File {
        let filePath = path.rawValue + filePath.rawValue.removeSafePrefix("/")
        let store = try Store<PLFile.File>(path: Path(filePath), fileManager: fileManager)
        return PLFile.File(store: store)
    }
    /// create subfolder to path
    func createSubfolder(at folderPath: Path) throws -> PLFile.Folder {
        let folderPath = path.rawValue + folderPath.rawValue.removeSafePrefix("/")
        if folderPath == path.rawValue { throw PLFileError.emptyPath(path: path) }
        do {
            try fileManager.createDirectory(
                atPath: folderPath,
                withIntermediateDirectories: true
            )
            let store = try Store(path: Path(folderPath), fileManager: fileManager)
            return PLFile.Folder(store: store)
        } catch {
            throw PLFileError.folderCreateError(path: path, error: error)
        }
    }
    /// create File to path
    func createFile(at filePath: Path, contents: Data? = nil) throws -> PLFile.File {
        let filePath = path.rawValue + filePath.rawValue.removeSafePrefix("/")
        let parentPath = Path(filePath).parents.rawValue
        if parentPath != path.rawValue {
            do {
                try fileManager.createDirectory(
                    atPath: parentPath,
                    withIntermediateDirectories: true
                )
            } catch {
                throw PLFileError.folderCreateError(path: Path(parentPath), error: error)
            }
        }
        guard fileManager.createFile(atPath: filePath, contents: contents) else {
            throw PLFileError.fileCreateError(path: Path(filePath))
        }
        let store = try Store<PLFile.File>(path: Path(filePath), fileManager: fileManager)
        return PLFile.File(store: store)
    }
}
