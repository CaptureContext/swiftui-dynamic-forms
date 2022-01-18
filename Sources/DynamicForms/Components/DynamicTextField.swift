public struct DynamicTextField: Equatable, DynamicElement {
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
  
  public var content: Never { fatalError() }
  public var node: DynamicElementNode { .primitive(.textField(self))}
}
