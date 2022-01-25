import DynamicForms
import SwiftUI

extension DynamicViews {
  public struct Toggle: View {
    public init(
      _ element: Binding<DynamicToggle?>,
      client: DynamicFormClient
    ) {
      self._element = element
      self.client = client
    }
    
    @Binding
    var element: DynamicToggle?
    let client: DynamicFormClient
    
    public var body: some View {
      SwiftUI.Toggle.init(
        isOn: $element.optionalRootMap(\.value).or(false),
        label: {
          ElementNode(
            $element.optionalRootMap(\.label),
            client: client
          )
        }
      )
    }
  }
}
