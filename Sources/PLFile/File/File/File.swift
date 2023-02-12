import Foundation

public extension PLFile.File {
    
    func write(_ data: Data) -> PLFile.Result {
        do {
            try data.write(to: url)
            return PLFile.Result.success
        } catch {
            return PLFile.Result.failure(path: url.absoluteString, message: error.localizedDescription)
        }
    }
}
