import Foundation

public enum DynamicElementModifierNode: Equatable, Codable {
  case padding(DynamicElementModifiers.Padding)
  case cornerRadius(DynamicElementModifiers.CornerRadius)
  case backgroundColor(DynamicElementModifiers.BackgroundColor)
  case foregroundColor(DynamicElementModifiers.ForegroundColor)
  
  public enum CodingKeys: CodingKey {
    case name
    case parameters
  }
  
  private enum Name: String, Codable {
    case padding
    case cornerRadius
    case backgroundColor
    case foregroundColor
  }
  
  private var name: Name {
    switch self {
    case .padding: return .padding
    case .cornerRadius: return .cornerRadius
    case .backgroundColor: return .backgroundColor
    case .foregroundColor: return .foregroundColor
    }
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    switch try container.decode(Name.self, forKey: .name) {
    case .padding:
      self = .padding(try container.decode(
        DynamicElementModifiers.Padding.self,
        forKey: .parameters
      ))
    case .cornerRadius:
      self = .cornerRadius(try container.decode(
        DynamicElementModifiers.CornerRadius.self,
        forKey: .parameters
      ))
    case .backgroundColor:
      self = .backgroundColor(try container.decode(
        DynamicElementModifiers.BackgroundColor.self,
        forKey: .parameters
      ))
    case .foregroundColor:
      self = .foregroundColor(try container.decode(
        DynamicElementModifiers.ForegroundColor.self,
        forKey: .parameters
      ))
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    switch self {
    case let .padding(parameters):
      try container.encode(parameters, forKey: .parameters)
    case let .cornerRadius(parameters):
      try container.encode(parameters, forKey: .parameters)
    case let .backgroundColor(parameters):
      try container.encode(parameters, forKey: .parameters)
    case let .foregroundColor(parameters):
      try container.encode(parameters, forKey: .parameters)
    }
  }
}
