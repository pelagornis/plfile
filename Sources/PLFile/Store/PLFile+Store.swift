import Foundation

public final class Store<fileSystem: FileSystem> {
    var path: Path
    private let fileManager: FileManager
    
    init(path: Path, fileManager: FileManager) {
        self.path = path
        self.fileManager = fileManager
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
}

extension Store where fileSystem == PLFile.Folder {
    /// subfolder information
    func subfolder(at folderPath: String) throws -> PLFile.Folder {
        let folderPath = path.rawValue + folderPath.removeSafePrefix("/")
        let store = Store(path: Path(folderPath), fileManager: fileManager)
        return PLFile.Folder(store: store)
    }
    /// file information
    func file(at filePath: String) throws -> PLFile.File {
        let filePath = path.rawValue + filePath.removeSafePrefix("/")
        let store = Store<PLFile.File>(path: Path(filePath), fileManager: fileManager)
        return PLFile.File(store: store)
    }
    /// create subfolder to path
    func createSubfolder(at folderPath: String) throws -> PLFile.Folder {
        let folderPath = path.rawValue + folderPath.removeSafePrefix("/")
        if folderPath == path.rawValue { throw PLFileError.emptyPath(path: path) }
        do {
            try fileManager.createDirectory(
                atPath: folderPath,
                withIntermediateDirectories: true
            )
            let store = Store(path: Path(folderPath), fileManager: fileManager)
            return PLFile.Folder(store: store)
        } catch {
            throw PLFileError.folderCreateError(path: path, error: error)
        }
    }
    /// create File to path
    func createFile(at filePath: String, contents: Data? = nil) throws -> PLFile.File {
        let filePath = path.rawValue + filePath.removeSafePrefix("/")
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
        let store = Store<PLFile.File>(path: Path(filePath), fileManager: fileManager)
        return PLFile.File(store: store)
    }
}
