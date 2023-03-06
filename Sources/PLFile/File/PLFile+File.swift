import Foundation

extension PLFile {
    public struct File: FileSystem {
        public var store: Store<PLFile.File>
        
        public init(store: Store<PLFile.File>) {
            self.store = store
        }
    }
}

/// Property
extension PLFile.File {
    public static var type: PLFileType {
        return .file
    }
}

/// Method
public extension PLFile.File {
    
//    /// write binary data in the file and replace current contexts
//    func write(_ data: Data) throws {
//        do {
//            try data.write(to: url)
//        } catch {
//            throw PLFileError.writeFailed(path: path, error: error)
//        }
//    }
//
//    /// write new string into the file and replace current contexts.
//    func write(_ string: String, encoding: String.Encoding = .utf8) throws {
//        guard let data = string.data(using: encoding) else {
//            throw PLFileError.writeStringEncodingFailed(path: path)
//        }
//        return try write(data)
//    }
//
//    /// append binary data in the file, exist contexts
//    func append(_ data: Data) throws {
//        do {
//            let handler = try FileHandle(forWritingTo: url)
//            _ = handler.seekToEndFactory()
//            handler.writeFactory(data)
//            handler.closeFileFactory()
//        } catch {
//            throw PLFileError.writeFailed(path: path, error: error)
//        }
//    }
//
//    /// append string into the file, exist contexts
//    func append(_ string: String, encoding: String.Encoding = .utf8) throws {
//        guard let data = string.data(using: encoding) else {
//            throw PLFileError.writeStringEncodingFailed(path: path)
//        }
//        return try append(data)
//    }
//
//    /// read the contents binary data in the file
//    func read() throws -> Data {
//        do {
//            return try Data(contentsOf: url)
//        } catch {
//            throw PLFileError.readFailed(path: path, error: error)
//        }
//    }
}
