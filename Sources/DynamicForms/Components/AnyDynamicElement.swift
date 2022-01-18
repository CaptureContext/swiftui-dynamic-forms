import Prelude

public struct AnyDynamicElement: DynamicElement {
  public static func == (
    lhs: AnyDynamicElement,
    rhs: AnyDynamicElement
  ) -> Bool {
    lhs.node == rhs.node
  }
  
  public init<T: DynamicElement>(_ component: T) {
    self._node = { component.node }
  }
  
  public var content: Never { fatalError() }
  
  public var _node: () -> DynamicElementNode
  
  public var node: DynamicElementNode { _node() }
}
