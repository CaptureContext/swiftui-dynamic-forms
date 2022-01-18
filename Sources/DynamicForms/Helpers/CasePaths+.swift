import CasePaths

extension CasePath {
  /// Helper function for enum properies
  ///
  /// Usage
  /// ```
  /// enum Enum {
  ///   case a(Int)
  ///   case b(Bool)
  ///
  ///   var a: Int? {
  ///     get { (/Self.a).extract(from: self) }
  ///     set { (/Self.a).ifCaseLetEmbed(newValue, in: &self) }
  ///   }
  ///
  ///   var b: Bool? {
  ///     get { (/Self.b).extract(from: self) }
  ///     set { (/Self.b).ifCaseLetEmbed(newValue, in: &self) }
  ///   }
  /// }
  /// ```
  func ifCaseLetEmbed(_ value: Value?, in root: inout Root) {
    guard extract(from: root) != nil, let value = value else { return }
    root = embed(value)
  }
}
