import CasePaths
import Foundation

public struct DynamicStack: Equatable, DynamicElement, Identifiable {
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
  
  public var content: Never { fatalError() }
  
  public var node: DynamicElementNode {
    .primitive(.stack(self))
  }
  
  public var children: [DynamicElementNode] {
    get { storage.group ?? [] }
    set { storage = .group(newValue) }
  }
}
