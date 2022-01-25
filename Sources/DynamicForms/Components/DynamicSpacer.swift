import Foundation

public struct DynamicSpacer: _PrimitiveDynamicElement {
  public init(
    id: DynamicElementIdentifier = .uuid(),
    minLength: Double? = nil
  ) {
    self.id = id
    self.minLength = minLength
  }
  
  public var id: DynamicElementIdentifier
  public var minLength: Double?
  
  public var __node: DynamicElementNode.Primitive {
    .init(.spacer(self))
  }
}
