import DynamicForms
import SwiftUI

extension DynamicViews {
  public struct TextField: View {
    public init(_ element: Binding<DynamicTextField?>) {
      self._element = element
    }
    
    @Binding
    var element: DynamicTextField?
    
    public var body: some View {
      SwiftUI.TextField.init(
        element.flatMap(\.key) ?? "",
        text: $element.optionalRootMap(\.value).or("")
      )
    }
  }
}
