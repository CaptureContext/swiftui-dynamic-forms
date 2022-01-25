import DynamicForms
import SwiftUI

extension DynamicViews {
  public struct ElementNode: View {
    public init(
      _ node: Binding<DynamicElementNode?>,
      client: DynamicFormClient
    ) {
      self._node = node
      self.client = client
    }
    
    @Binding
    var node: DynamicElementNode?
    
    var client: DynamicFormClient
    
    public var body: some View {
      switch node {
      case .primitive:
        PrimitiveNode(
          $node.optionalMap(\.primitive),
          client: client
        )
        
      case .group:
        DynamicForEachView<PrimitiveNode>(
          $node.optionalMap(\.group).or([]),
          client: client
        )
        
      default:
        EmptyView()
      }
    }
  }
}
