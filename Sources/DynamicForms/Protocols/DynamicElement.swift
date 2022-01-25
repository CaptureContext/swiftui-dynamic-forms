import Prelude
import CasePaths

public protocol DynamicElement: Equatable {
  associatedtype Content: DynamicElement
  var content: Content { get }
  var node: DynamicElementNode { get }
}

extension DynamicElement {
  public var node: DynamicElementNode {
    content.node
  }
}

public protocol _PrimitiveDynamicElement: DynamicElement where Content == Never {
  var __node: DynamicElementNode.Primitive { get }
}

extension _PrimitiveDynamicElement {
  public var content: Content { fatalError() }
  public var node: DynamicElementNode { .primitive(__node) }
}

extension Never: DynamicElement {
  public var content: Never { fatalError() }
  public var node: DynamicElementNode {
    .group(.init())
  }
}

extension Optional: DynamicElement where Wrapped: DynamicElement {
  public var content: Never { fatalError() }
  public var node: DynamicElementNode {
    self.map(\.node) ?? .group(.init())
  }
}
