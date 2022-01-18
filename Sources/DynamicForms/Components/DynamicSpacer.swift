import Foundation

public struct DynamicSpacer: Equatable, DynamicElement, Identifiable {
  public init(
    id: DynamicElementIdentifier = .uuid(),
    minLength: Double?
  ) {
    self.id = id
    self.minLength = minLength
  }
  
  public var id: DynamicElementIdentifier
  public var minLength: Double?
  public var content: Never { fatalError() }
  public var node: DynamicElementNode { .primitive(.spacer(self)) }
}
