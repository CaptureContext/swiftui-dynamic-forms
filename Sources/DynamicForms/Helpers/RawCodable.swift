public typealias RawCodable = RawEncodable & RawDecodable

public protocol RawEncodable: RawRepresentable, Encodable
where RawValue: Encodable {}

extension RawEncodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}

public protocol RawDecodable: RawRepresentable, Decodable
where RawValue: Decodable {}

extension RawDecodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let value = try container.decode(RawValue.self)
    if let object = Self.init(rawValue: value) {
      self = object
    } else {
      throw RawDecodableInitializationFailed<Self>()
    }
  }
}

public struct RawDecodableInitializationFailed<T: RawDecodable>: Error {
  public let type: T.Type
  public let function: String
  public let file: String
  public let line: Int
  
  init(
    _ type: T.Type = T.self,
    function: String = #function,
    file: String = #file,
    line: Int = #line
  ) {
    self.type = type
    self.function = function
    self.file = file
    self.line = line
  }
  
  @inlinable
  public var localizedDescription: String {
    "Unsupported raw value decoded for \(type)."
  }
  
  @inlinable
  public var debugDescription: String {
    localizedDescription
      .appending("\n{")
      .appending("\n    function: \(function)")
      .appending("\n    file: \(file),")
      .appending("\n    line: \(line)")
      .appending("\n}")
  }
}
