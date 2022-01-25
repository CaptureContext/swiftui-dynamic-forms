import Foundation

@dynamicMemberLookup
public struct DynamicForm: Equatable {
  public var content: DynamicElementNode.Primitive
  
  
  public init<Content: _PrimitiveDynamicElement>(content: () -> Content) {
    self.init(content().__node)
  }
  
  public init(_ node: DynamicUINode) {
    self.init(.init(node))
  }
  
  public init(_ content: DynamicElementNode.Primitive) {
    self.content = content
  }
  public subscript<Value>(
    dynamicMember keyPath: WritableKeyPath<DynamicUINode, Value>
  ) -> Value {
    set { content.node[keyPath: keyPath] = newValue }
    get { content.node[keyPath: keyPath] }
  }
}


