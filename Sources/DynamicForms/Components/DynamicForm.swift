import Foundation

@dynamicMemberLookup
public struct DynamicForm: Equatable {
  public var node: DynamicUINode
  
  public init(_ node: DynamicUINode) {
    self.node = node
  }
  
  public init(content: () -> DynamicText) {
    self.init(content().node.primitive!)
  }
  
//  init(content: () -> DynamicTextInput) {
//    self.init(content().__renderDynamicNodesStorage().first!)
//  }

  public init(content: () -> DynamicButton) {
    self.init(content().node.primitive!)
  }
  
  public init(content: () -> DynamicStack) {
    self.init(content().node.primitive!)
  }
  
  public subscript<Value>(
    dynamicMember keyPath: WritableKeyPath<DynamicUINode, Value>
  ) -> Value {
    set { node[keyPath: keyPath] = newValue }
    get { node[keyPath: keyPath] }
  }
}


