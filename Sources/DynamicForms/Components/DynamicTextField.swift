public struct DynamicTextField: _PrimitiveDynamicElement {
  public init(
    id: DynamicElementIdentifier = .uuid(),
    key: String? = nil,
    value: String
  ) {
    self.id = id
    self.key = key
    self.value = value
  }
  
  public var id: DynamicElementIdentifier
  public var key: String?
  public var value: String
  
  public var __node: DynamicElementNode.Primitive { .init(.textField(self)) }
}
