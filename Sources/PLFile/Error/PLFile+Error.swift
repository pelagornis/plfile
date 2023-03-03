import Foundation

/// error can be thrown by PLFile
public enum PLFileError: Error {
    // write
    case writeFailed(path: Path, error: Error)
    case writeStringEncodingFailed(path: Path)
    //read
    case readFailed(path: Path, error: Error)
    
}

extension PLFileError {
    
    /// PLFile Error Return Error Context
    public var error: Error? {
        switch self {
        case .writeFailed(_, let error),
                .readFailed(_,let error):
            return error
        case .writeStringEncodingFailed:
            return nil
        }
    }
    
    /// PLFile Error Reason Message
    public var message: String {
        switch self {
        case let .writeFailed(path, _):
            return "Could not write to file -> \(path)"
        case let .writeStringEncodingFailed(path):
            return "Could not write String Encoding to file -> \(path)"
        case let .readFailed(path, _):
            return "Could not read to file -> \(path)"
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
