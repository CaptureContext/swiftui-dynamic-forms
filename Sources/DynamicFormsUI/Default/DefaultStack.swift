import DynamicForms
import SwiftUI

extension DynamicViews {
  public struct Stack: View {
    public init(
      _ element: Binding<DynamicStack?>,
      client: DynamicFormClient
    ) {
      self._element = element
      self.client = client
    }
    
    @Binding
    var element: DynamicStack?
    let client: DynamicFormClient
    
    @ViewBuilder
    public var body: some View {
      switch element?.axis {
      case .vertical:
        VStack {
          DynamicForEachView<PrimitiveNode>(
            $element
              .optionalRootMap(\.children)
              .or([]),
            client: client
          )
        }
        
      case .horizontal:
        HStack {
          DynamicForEachView<PrimitiveNode>(
            $element
              .optionalRootMap(\.children)
              .or([]),
            client: client
          )
        }
        
      default:
        EmptyView()
      }
    }
  }
}
