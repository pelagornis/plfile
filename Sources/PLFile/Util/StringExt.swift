extension String {
  /**
   Appends a suffix to the string, but only if the string does not already end with that suffix.

   - Parameter suffix: The suffix to append.

   - Returns: A new string with the suffix appended, or the original string if it already ends with the suffix.
   */
  func appendSafeSuffix(_ suffix: String) -> String {
    guard !hasSuffix(suffix) else { return self }
    return appending(suffix)
  }

  /**
   Removes a prefix from the string, but only if the string starts with that prefix.

   - Parameter prefix: The prefix to remove.

   - Returns: A new string with the prefix removed, or the original string if it does not start with the prefix.
   */
  func removeSafePrefix(_ prefix: String) -> String {
    guard hasPrefix(prefix) else { return self }
    return String(dropFirst(prefix.count))
  }
}
