import SwiftUI
import DynamicForms

public struct DynamicFormView<
  PrimitiveNode: PrimitiveDynamicNodeView
>: View {
  @Binding
  var form: DynamicForm
  
  var client: DynamicFormClient
  
  public init(
    _ form: Binding<DynamicForm>,
    client: DynamicFormClient = .shared
  ) {
    self._form = form
    self.client = client
  }
  
  public var body: some View {
    PrimitiveNode(
      $form.node.optional(),
      client: client
    )
  }
}
