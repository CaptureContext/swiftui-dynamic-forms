import Foundation

public struct DynamicElementIdentifier: Equatable, Hashable, RawRepresentable {
  public init(rawValue: String) {
    self.rawValue = rawValue
  }
  
  public var rawValue: String
}

extension DynamicElementIdentifier: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(rawValue: value)
  }
}

extension DynamicElementIdentifier: ExpressibleByStringInterpolation {
  public init(stringInterpolation value: DefaultStringInterpolation) {
    self.init(rawValue: String(stringInterpolation: value))
  }
}

extension DynamicElementIdentifier {
  public static func uuid(_ value: UUID = .init()) -> DynamicElementIdentifier {
    return .init(rawValue: value.uuidString)
  }
}
