import CasePaths
import Foundation

public struct DynamicStack: _PrimitiveDynamicElement {
  public enum Axis: Equatable {
    case vertical
    case horizontal
  }
  
  public init(
    _ axis: Axis,
    @DynamicUIBuilder content: () -> _DynamicTupleElement
  ) {
    self.init(
      axis,
      storage: content().node
    )
  }
  
  internal init(
    _ axis: Axis,
    id: DynamicElementIdentifier = .uuid(),
    storage: DynamicElementNode
  ) {
    self.id = id
    self.axis = axis
    self.storage = storage
  }
  
  public let id: DynamicElementIdentifier
  public var axis: Axis
  private var storage: DynamicElementNode
  
  public var __node: DynamicElementNode.Primitive { .init(.stack(self)) }
  
  public var children: [DynamicElementNode] {
    get { storage.group?.nodes ?? [] }
    set { storage.group?.nodes = newValue }
  }
}
