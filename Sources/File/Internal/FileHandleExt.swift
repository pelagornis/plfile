import Foundation

extension FileHandle {

    /// Seeks to the end of the file handle.
    ///
    /// - Returns: The current offset from the beginning of the file.
    ///
    /// - Note: `seekToEndOfFile()` is deprecated in macOS 10.15.4, so this method provides a replacement.
    func seekToEndFactory() -> UInt64 {
        if #available(iOS 13.4, macOS 10.15.4, tvOS 13.4, watchOS 6.2, visionOS 1.0, *) {
            do {
                return try self.seekToEnd()
            } catch {
                return 0
            }
        } else {
            return self.seekToEndOfFile()
        }
    }
    
    ///  Writes the given data to the file handle.
    ///
    /// - Parameter data: The data to write.
    ///
    /// - Note: `write(_ data: Data)` is deprecated in macOS 10.15.4, so this method provides a replacement.
    func writeFactory(_ data: Data) {
        if #available(iOS 13.4, macOS 10.15.4, tvOS 13.4, watchOS 6.2, visionOS 1.0, *) {
            do {
                try self.write(contentsOf: data)
            } catch {
                return
            }
        } else {
            self.write(data)
        }
    }
    
    /// Closes the file handle.
    ///
    /// - Note: `closeFile()` is deprecated in macOS 10.15, so this method provides a replacement.
    func closeFileFactory() {
        if #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *) {
            do {
                try self.close()
            } catch { return }
        } else {
            self.closeFile()
        }
    }
}
