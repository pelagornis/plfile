import Foundation

extension Data {

    /// Converts the `Data` object to a `String` using the specified encoding.
    ///
    /// - Parameter encoding: The string encoding to use. Default is `.utf8`.
    ///
    /// - Returns: A `String` representation of the `Data` object, or an empty string if the conversion fails.
    func stringEncoding(encoding: String.Encoding = .utf8) -> String {
        guard let string = String(data: self, encoding: encoding) else { return "" }
        return string
    }
}
