public struct DynamicToggle: Equatable, _PrimitiveDynamicElement {
  public var id: DynamicElementIdentifier
  public var value: Bool
  public var label: DynamicElementNode?
  
  public init(
    _ title: String,
    id: DynamicElementIdentifier = .uuid(),
    value: Bool = false
  ) {
    self.init(
      id: id,
      value: value
    ) {
      DynamicText(title)
    }
  }
  
  public init(
    id: DynamicElementIdentifier = .uuid(),
    value: Bool = false
  ) {
    self.id = id
    self.value = value
    self.label = nil
  }
  
  public init<Label: DynamicElement>(
    id: DynamicElementIdentifier = .uuid(),
    value: Bool = false,
    label: () -> Label
  ) {
    self.id = id
    self.value = value
    self.label = label().node
  }
  
  public var __node: DynamicElementNode.Primitive {
    .init(.toggle(self))
  }
}
