import DynamicForms
import SwiftUI

extension DynamicViews {
  public struct Button: View {
    public init(
      _ element: Binding<DynamicButton?>,
      client: DynamicFormClient = .shared
    ) {
      self._element = element
      self.client = client
    }
    
    @Binding
    var element: DynamicButton?
    
    let client: DynamicFormClient
    
    public var body: some View {
      element.map { element in
        SwiftUI.Button {
          client.send(.init(id: element.id, action: element.action))
        } label: {
          ElementNode(
            $element.optionalRootMap(\.label),
            client: client
          )
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
      }
    }
  }
}
