public struct DynamicToggle: Equatable, DynamicElement {
  public var id: DynamicElementIdentifier
  public var value: Bool
  public var label: DynamicElementNode
  
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
  
  public init<Label: DynamicElement>(
    id: DynamicElementIdentifier = .uuid(),
    value: Bool = false,
    label: () -> Label
  ) {
    self.id = id
    self.value = value
    self.label = label().node
  }
  
  public var content: Never { fatalError() }
  public var node: DynamicElementNode { .primitive(.toggle(self))}
}
