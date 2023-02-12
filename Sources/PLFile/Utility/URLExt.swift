import Foundation

extension URL {
    init(path: String) {
        if #available(macOS 13.0, *) {
            self.init(filePath: path)
        } else {
            self.init(fileURLWithPath: path)
        }
    }
}
