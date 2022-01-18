public struct DynamicButton: DynamicElement, Identifiable {
  public var id: AnyHashable { action }
  public var label: DynamicElementNode
  public var action: AnyHashable
  
  public init<Label: DynamicElement>(
    _ label: Label,
    action: AnyHashable
  ) {
    self.label = label.node
    self.action = action
  }
  
  public var content: Never { fatalError() }
  
  public var node: DynamicElementNode {
    .primitive(.button(self))
  }
}
