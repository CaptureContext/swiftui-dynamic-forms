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

extension Never: DynamicElement {
  public var content: Never { fatalError() }
  public var node: DynamicElementNode {
    .group([])
  }
}

extension Optional: DynamicElement where Wrapped: DynamicElement {
  public var content: Never { fatalError() }
  public var node: DynamicElementNode {
    self.map(\.node) ?? .group([])
  }
}
