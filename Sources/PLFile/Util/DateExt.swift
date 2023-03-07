import Foundation

extension Data {
    func stringEncoding(encoding: String.Encoding = .utf8) -> String {
        guard let string = String(data: self, encoding: encoding) else { return "" }
        return string
    }
}
