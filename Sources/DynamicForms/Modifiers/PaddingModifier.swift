extension DynamicElement {
  public func padding(
    _ edges: DynamicElementModifiers.Padding.Edge.Set = .all,
    _ value: Double = 12
  ) -> some DynamicElement {
    return modifier(
      DynamicElementModifiers.Padding(
        edges,
        value
      )
    )
  }
}


extension DynamicElementModifiers {
  public struct Padding: DynamicElementModifier {
    public enum Edge: String, Hashable, RawCodable {
      case top
      case bottom
      case leading
      case trailing
      
      public struct Set: OptionSet, Equatable, Codable {
        public let rawValue: Int
        
        public init(rawValue: Int) {
          self.rawValue = rawValue
        }
        
        public static let top      = Self(rawValue: 1 << 0)
        public static let bottom   = Self(rawValue: 1 << 1)
        public static let leading  = Self(rawValue: 1 << 2)
        public static let trailing = Self(rawValue: 1 << 3)
        public static let vertical   : Self = [.top, .bottom]
        public static let horizontal : Self = [.leading, .trailing]
        public static let all        : Self = [.vertical, .horizontal]
        
        init(_ edges: Swift.Set<Edge>) {
          var value: Self = []
          edges.forEach { edge in
            switch edge {
            case .top: value.insert(.top)
            case .bottom: value.insert(.bottom)
            case .leading: value.insert(.leading)
            case .trailing: value.insert(.trailing)
            }
          }
          self = value
        }
      
        public init(from decoder: Decoder) throws {
          let container = try decoder.singleValueContainer()
          self.init(try container.decode(Swift.Set<Edge>.self))
        }
        
        public func encode(to encoder: Encoder) throws {
          var container = encoder.singleValueContainer()
          var items: Swift.Set<Edge> = []
          
          if self.contains(.top) { items.insert(.top) }
          if self.contains(.bottom) { items.insert(.bottom) }
          if self.contains(.leading) { items.insert(.leading) }
          if self.contains(.trailing) { items.insert(.trailing) }
          
          try container.encode(items)
        }
      }
    }
    
    public init(
      _ edges: Edge.Set = .all,
      _ value: Double
    ) {
      self.edges = edges
      self.value = value
    }
    
    public var edges: Edge.Set
    public var value: Double
    
    public var node: DynamicElementModifierNode {
      .padding(self)
    }
  }
}
