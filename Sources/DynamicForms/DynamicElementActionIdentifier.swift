public struct DynamicElementActionIdentifier: Equatable, Hashable, RawRepresentable {
  public init(rawValue: String) {
    self.rawValue = rawValue
  }
  
  public var rawValue: String
}

extension DynamicElementActionIdentifier: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(rawValue: value)
  }
}

extension DynamicElementActionIdentifier: ExpressibleByStringInterpolation {
  public init(stringInterpolation value: DefaultStringInterpolation) {
    self.init(rawValue: String(stringInterpolation: value))
  }
}
