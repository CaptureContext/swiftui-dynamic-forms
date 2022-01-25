import DynamicForms
import SwiftUI

extension DynamicViews {
  public struct PrimitiveNode: PrimitiveDynamicNodeView {
    public init(
      _ node: Binding<DynamicUINode?>,
      client: DynamicFormClient
    ) {
      self._node = node
      self.client = client
    }
    
    @Binding
    var node: DynamicUINode?
    
    var client: DynamicFormClient
    
    @ViewBuilder
    public var body: some View {
      switch node {
      case .button:
        Button(
          $node.optionalMap(\.button),
          client: client
        )
        
      case let .spacer(state):
        Spacer(state)
        
      case .stack:
        Stack(
          $node.optionalMap(\.stack),
          client: client
        )
        
      case let .text(state):
        Text(state)
        
      case .textField:
        TextField(
          $node.optionalMap(\.textField)
        )
        
      case .textView:
        TextView(
          $node.optionalMap(\.textView)
        )
        
      case .none:
        EmptyView()
      }
    }
  }
}
