import DynamicForms
import SwiftUI

public struct DynamicForEachView<
  PrimitiveNode: PrimitiveDynamicNodeView
>: View {
  public init(
    _ nodes: Binding<[DynamicElementNode]>,
    client: DynamicFormClient
  ) {
    self._nodes = nodes
    self.client = client
  }
  
  @Binding
  var nodes: [DynamicElementNode]
  
  var client: DynamicFormClient
  
  public var body: some View {
    SwiftUI.ForEach($nodes) { node in
      switch node.wrappedValue {
      case .primitive:
        PrimitiveNode(node.primitive, client: client)
        
      case .group:
        DynamicForEachView(
          node.optionalValueMap(\.group).or([]),
          client: client
        )
      }
    }
  }
  }
