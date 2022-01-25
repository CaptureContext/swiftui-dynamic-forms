public struct ModifiedDynamicElement: DynamicElement {
  init(_ node: DynamicElementNode) {
    self.node = node
  }
  
  public var content: Never { fatalError() }
  private(set) public var node: DynamicElementNode
}
