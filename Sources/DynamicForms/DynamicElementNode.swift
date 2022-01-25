import CasePaths

public indirect enum DynamicElementNode: Equatable, Identifiable {
  case primitive(Primitive)
  case group(Group)
}

extension DynamicElementNode {
  public var id: AnyHashable {
    switch self {
    case let .primitive(primitive): return primitive.id
    case let .group(group): return group.id
    }
  }
  
  public var primitive: Primitive? {
    get { (/Self.primitive).extract(from: self) }
    set { (/Self.primitive).ifCaseLetEmbed(newValue, in: &self) }
  }
  
  public var group: Group? {
    get { (/Self.group).extract(from: self) }
    set { (/Self.group).ifCaseLetEmbed(newValue, in: &self) }
  }
  
  public var modifiers: [DynamicElementModifierNode] {
    get {
      switch self {
      case let .primitive(primitive):
        return primitive.modifiers
      case let .group(group):
        return group.modifiers
      }
    }
    set {
      switch self {
      case var .primitive(primitive):
        primitive.modifiers = newValue
        self = .primitive(primitive)
      case var .group(group):
        group.modifiers = newValue
        self = .group(group)
      }
    }
  }
  
  public var nodes: [DynamicElementNode] {
    switch self {
    case .primitive: return [self]
    case let .group(group): return group.nodes
    }
  }
  
  public struct Primitive: Equatable, Identifiable {
    public init(
      _ node: DynamicUINode,
      modifiers: [DynamicElementModifierNode] = []
    ) {
      self.node = node
      self.modifiers = modifiers
    }
    
    public var id: DynamicElementIdentifier { node.id }
    public var node: DynamicUINode
    public var modifiers: [DynamicElementModifierNode]
  }
  
  public struct Group: Equatable, Identifiable {
    public init(
      _ nodes: [DynamicElementNode] = [],
      modifiers: [DynamicElementModifierNode] = []
    ) {
      self.nodes = nodes
      self.modifiers = modifiers
    }
    
    public var id: AnyHashable { nodes.map(\.id) }
    public var nodes: [DynamicElementNode]
    public var modifiers: [DynamicElementModifierNode]
  }

}
