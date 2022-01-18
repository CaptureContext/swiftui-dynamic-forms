import SwiftUI

public struct DynamicFormView: View {
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
    PrimitiveNodeView(
      Binding(
        get: { form.node },
        set: { $0.map { form.node = $0 } }
      ),
      client: client
    )
  }
}


extension DynamicFormView {
  struct ElementNodeView: View {
    init(
      _ node: Binding<DynamicElementNode?>,
      client: DynamicFormClient
    ) {
      self._node = node
      self.client = client
    }
    
    @Binding
    var node: DynamicElementNode?
    
    var client: DynamicFormClient
    
    var body: some View {
      switch node {
      case .primitive:
        PrimitiveNodeView(
          Binding(
            get: { node?.primitive },
            set: { node?.primitive = $0 }
          ),
          client: client
        )
        
      case .group:
        ForEachView(
          Binding(
            get: { node?.group ?? [] },
            set: { node?.group = $0 }
          ),
          client: client
        )
        
      default:
        EmptyView()
      }
    }
  }
  
  struct PrimitiveNodeView: View {
    init(
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
    var body: some View {
      switch node {
      case let .button(state):
        Button {
          client.send(.init(
            id: state.id,
            action: state.action
          ))
        } label: {
          ElementNodeView(
            Binding(
              get: { node?.button?.label },
              set: { $0.map { node?.button?.label = $0 } }
            ),
            client: client
          )
        }
        
      case let .spacer(state):
        Spacer(minLength: state.minLength.map { CGFloat($0) })
        
      case let .stack(state):
        switch state.axis {
        case .vertical:
          VStack {
            ForEachView(
              Binding(
                get: { node?.stack?.children ?? [] },
                set: { node?.stack?.children = $0 }
              ),
              client: client
            )
          }
          
        case .horizontal:
          HStack {
            ForEachView(
              Binding(
                get: { node?.stack?.children ?? [] },
                set: { node?.stack?.children = $0 }
              ),
              client: client
            )
          }
        }
        
      case let .text(state):
        state
        
      case let .textField(state):
        TextField(
          state.key ?? "",
          text: Binding(
            get: { node?.textField?.value ?? "" },
            set: { node?.textField?.value = $0 }
          )
        )
        
      case .textView:
        TextEditor(text: Binding(
          get: { node?.textField?.value ?? "" },
          set: { node?.textField?.value = $0 }
        ))
        
      case .none:
        EmptyView()
      }
    }
  }
  
  struct ForEachView: View {
    init(
      _ nodes: Binding<[DynamicElementNode]>,
      client: DynamicFormClient
    ) {
      self._nodes = nodes
      self.client = client
    }
    
    @Binding
    var nodes: [DynamicElementNode]
    
    var client: DynamicFormClient
    
    var body: some View {
      ForEach($nodes) { node in
        switch node.wrappedValue {
        case .primitive:
          PrimitiveNodeView(node.primitive, client: client)
          
        case .group:
          ForEachView(
            Binding(
              get: { node.group.wrappedValue ?? [] },
              set: { node.group.wrappedValue = $0 }
            ),
            client: client
          )
        }
      }
    }
  }
}
