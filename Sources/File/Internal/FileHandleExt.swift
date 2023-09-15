import Foundation

public extension FileHandle {

    /**
     Seeks to the end of the file handle.

     - Returns: The current offset from the beginning of the file.

     - Note: `seekToEndOfFile()` is deprecated in macOS 10.15.4, so this method provides a replacement.
     */
    func seekToEndFactory() -> UInt64 {
        if #available(macOS 10.15.4, *) {
            do {
                if #available(iOS 13.4, *) {
                    return try self.seekToEnd()
                } else {
                    return 0
                }
            } catch {
                return 0
            }
        } else {
            return self.seekToEndOfFile()
        }
    }
    
    /**
     Writes the given data to the file handle.

     - Parameter data: The data to write.

     - Note: `write(_ data: Data)` is deprecated in macOS 10.15.4, so this method provides a replacement.
     */
    func writeFactory(_ data: Data) {
        if #available(macOS 10.15.4, *) {
            do {
                if #available(iOS 13.4, *) {
                    try self.write(contentsOf: data)
                } else {
                    return
                }
            } catch {
                return
            }
        } else {
            self.write(data)
        }
    }
    
    /**
     Closes the file handle.

     - Note: `closeFile()` is deprecated in macOS 10.15, so this method provides a replacement.
     */
    func closeFileFactory() {
        if #available(macOS 10.15, *) {
            do {
                if #available(iOS 13.0, *) {
                    try self.close()
                } else {
                    return
                }
            } catch { return }
        } else {
            self.closeFile()
        }
    }
}

