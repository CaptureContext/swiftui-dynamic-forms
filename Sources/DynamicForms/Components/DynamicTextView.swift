public struct DynamicTextView: _PrimitiveDynamicElement {
  public init(
    id: DynamicElementIdentifier = .uuid(),
    value: String
  ) {
    self.id = id
    self.value = value
  }
  
  public var id: DynamicElementIdentifier
  public var value: String
  
  public var __node: DynamicElementNode.Primitive { .init(.textView(self)) }
}
