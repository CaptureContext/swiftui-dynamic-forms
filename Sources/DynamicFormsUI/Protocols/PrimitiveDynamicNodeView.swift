import DynamicForms
import SwiftUI

public protocol PrimitiveDynamicNodeView: View {
  init(
    _ node: Binding<DynamicUINode?>,
    client: DynamicFormClient
  )
}
