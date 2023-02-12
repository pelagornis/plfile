import Foundation

public final class Storage<PLFileType: DirectoryPath> {
    private(set) var path: Path = .init("")
    private let fileManager: FileManager
    
    init(path: Path, fileManager: FileManager){
        self.path = path
        self.fileManager = fileManager
    }
}

extension Storage {
    var attirbutes: [FileAttributeKey : Any] {
        return (try? fileManager.attributesOfItem(atPath: path.safeRawValue)) ?? [:]
    }
    
}

//MARK: - Method
extension Storage {
    func move(to newPath: String) -> PLFile.Result {
        do {
            try fileManager.moveItem(atPath: path.safeRawValue, toPath: newPath)
            
            switch PLFileType.directoryType {
            case .file:
                path.rawValue = newPath
            case .folder:
                path.rawValue = newPath.addSuffix("/")
            }
            return PLFile.Result.success
        } catch {
            return PLFile.Result.failure(path: path.rawValue, message: error.localizedDescription)
        }
    }
}
