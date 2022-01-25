public struct DynamicButton: _PrimitiveDynamicElement {
  public var id: DynamicElementIdentifier
  public var label: DynamicElementNode
  public var action: DynamicElementActionIdentifier
  
  public init(
    _ title: String,
    id: DynamicElementIdentifier = .uuid(),
    action: DynamicElementActionIdentifier
  ) {
    self.init(
      id: id,
      action: action
    ) {
      DynamicText(title)
    }
  }
  
  public init<Label: DynamicElement>(
    id: DynamicElementIdentifier = .uuid(),
    action: DynamicElementActionIdentifier,
    label: () -> Label
  ) {
    self.id = id
    self.label = label().node
    self.action = action
  }
  
  public var __node: DynamicElementNode.Primitive {
    .init(.button(self))
  }
}
