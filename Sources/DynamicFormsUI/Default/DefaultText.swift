import DynamicForms
import SwiftUI

extension DynamicViews {
  public struct Text: View {
    public init(_ element: DynamicText) {
      self.element = element
    }
    
    let element: DynamicText
    
    public var body: some View {
      SwiftUI.Text(element)
    }
  }
}
