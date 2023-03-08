import Foundation

/// error can be thrown by PLFile
public enum PLFileError: Error {
    /// file
    case fileCreateError(path: Path)
    case filePathEmpty(path: Path)
    /// folder
    case folderCreateError(path: Path, error: Error)
    /// path
    case emptyPath(path: Path)
    // write
    case writeFailed(path: Path, error: Error)
    case writeStringEncodingFailed(path: Path)
    // read
    case readFailed(path: Path, error: Error)
    /// fileSystem Error
    case cannotRename(path: Path)
    case moveError(path: Path, error: Error)
    case copyError(path: Path, error: Error)
    case deleteError(path: Path, error: Error)
    /// missing
    case missing(path: Path)
}

extension PLFileError {
    
    /// PLFile Error Return Error Context
    public var error: Error? {
        switch self {
        case .writeFailed(_, let error),
                .folderCreateError(_, let error),
                .readFailed(_, let error),
                .moveError(_, let error),
                .copyError(_, let error),
                .deleteError(_, let error):
            return error
        case .writeStringEncodingFailed,
                .fileCreateError,
                .cannotRename,
                .emptyPath,
                .filePathEmpty,
                .missing:
            return nil
        }
    }
    
    /// PLFile Error Reason Message
    public var message: String {
        switch self {
        case let .writeFailed(path, _):
            return "Could not write to file -> \(path)"
        case let .fileCreateError(path):
            return "Could not Create File -> \(path)"
        case let .filePathEmpty(path):
            return "File Path is Empty -> \(path)"
        case let .folderCreateError(path, _):
            return "Could not Create Folder -> \(path)"
        case let .writeStringEncodingFailed(path):
            return "Could not write String Encoding to file -> \(path)"
        case let .emptyPath(path):
            return "Could not write to empty path -> \(path)"
        case let .readFailed(path, _):
            return "Could not read to file -> \(path)"
        case let .moveError(path, _):
            return "Could not move to new path -> \(path)"
        case let .copyError(path, _):
            return "Could not copy to file -> \(path)"
        case let .deleteError(path, _):
            return "Could not delete to file -> \(path)"
        case let .cannotRename(path):
            return "Could not rename -> \(path)"
        case let .missing(path):
            return "Could not find missing -> \(path)"
        }
    }
}

//MARK: - CustomStringConvertible
extension PLFileError: CustomStringConvertible {
    /// representation of `self`
    public var description: String {
        return String(describing: type(of: self)) + ": (\(message)"
    }
}

//MARK: - CustomDebugStringConvertible
extension PLFileError: CustomDebugStringConvertible {
    
    /// representation of instance, suitable for debugging
    public var debugDescription: String {
        guard let error = error else {
            return self.debugDescription
        }
        return self.description + ":) \(error)"
    }
}
