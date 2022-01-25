import DynamicForms
import SwiftUI

extension DynamicViews {
  public struct TextView: View {
    public init(_ element: Binding<DynamicTextView?>) {
      self._element = element
    }
    
    @Binding
    var element: DynamicTextView?
    
    public var body: some View {
      SwiftUI.TextEditor.init(
        text: $element.optionalRootMap(\.value).or("")
      )
    }
  }
}
