import CasePaths

public indirect enum DynamicElementNode: Equatable, Identifiable {
  case primitive(DynamicUINode)
  case group([DynamicElementNode])
}

extension DynamicElementNode {
  public var id: AnyHashable {
    switch self {
    case let .primitive(node): return node.id
    case let .group(nodes): return nodes.map(\.id)
    }
  }
  
  public var primitive: DynamicUINode? {
    get { (/Self.primitive).extract(from: self) }
    set { (/Self.primitive).ifCaseLetEmbed(newValue, in: &self) }
  }
  
  public var group: [DynamicElementNode]? {
    get { (/Self.group).extract(from: self) }
    set { (/Self.group).ifCaseLetEmbed(newValue, in: &self) }
  }
  
  public var nodes: [DynamicElementNode] {
    switch self {
    case .primitive: return [self]
    case let .group(nodes): return nodes
    }
  }
}
