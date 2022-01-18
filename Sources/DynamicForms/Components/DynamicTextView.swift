public struct DynamicTextView: Equatable, DynamicElement {
  public init(
    id: DynamicElementIdentifier = .uuid(),
    value: String
  ) {
    self.id = id
    self.value = value
  }
  
  public var id: DynamicElementIdentifier
  public var value: String
  
  public var content: Never { fatalError() }
  public var node: DynamicElementNode { .primitive(.textView(self))}
}
