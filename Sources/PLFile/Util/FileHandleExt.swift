import Foundation

public extension FileHandle {
    /// seekToEndOfFile is Deprecated in 10.15.4, So use seekToEndFactory
    func seekToEndFactory() -> UInt64 {
        if #available(macOS 10.15.4, *) {
            do {
                return try self.seekToEnd()
            } catch {
                return 0
            }
        } else {
            return self.seekToEndOfFile()
        }
    }
    
    /// write(_ data: Data) is Deprecated in 10.15.4, So use writeFactory
    func writeFactory(_ data: Data) {
        if #available(macOS 10.15.4, *) {
            do {
                try self.write(contentsOf: data)
            } catch {
                return
            }
        } else {
            self.write(data)
        }
    }
    
    /// closeFile() is Deprecated in 10.15, So use closeFileFactory
    func closeFileFactory() {
        if #available(macOS 10.15, *) {
            do {
                try self.close()
            } catch { return }
        } else {
            self.closeFile()
        }
    }
}
