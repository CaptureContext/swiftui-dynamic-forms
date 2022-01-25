import DynamicForms
import SwiftUI

extension DynamicViews {
  public struct Spacer: View {
    public init(_ element: DynamicSpacer?) {
      self.element = element
    }
    
    let element: DynamicSpacer?
    
    public var body: some View {
      element.map { spacer in
        SwiftUI.Spacer(
          minLength: spacer.minLength.map { CGFloat($0) }
        )
      }
    }
  }
}
