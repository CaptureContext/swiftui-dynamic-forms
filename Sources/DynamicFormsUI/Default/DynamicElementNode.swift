import DynamicForms
import SwiftUI

extension DynamicViews {
  public struct ElementNode: View {
    public init(
      _ node: Binding<DynamicElementNode?>,
      client: DynamicFormClient
    ) {
      self._node = node
      self.client = client
    }
    
    @Binding
    var node: DynamicElementNode?
    
    var client: DynamicFormClient
    
    public var body: some View {
      content().modified(using: node?.modifiers)
    }
    
    @ViewBuilder
    func content() -> some View {
      switch node {
      case .primitive:
        PrimitiveNode(
          $node
            .optionalMap(\.primitive)
            .optionalRootMap(\.node),
          client: client
        )
        
      case .group:
        DynamicForEachView<PrimitiveNode>(
          $node
            .optionalMap(\.group)
            .optionalRootMap(\.nodes)
            .or([]),
          client: client
        )
        
      default:
        EmptyView()
      }
    }
  }
}

extension View {
  public func modified(
    using modifiers: [DynamicElementModifierNode]?
  ) -> some View {
    DynamicModifiersView(modifiers ?? []) {
      self
    }
  }
}

struct DynamicModifiersView: View {
  init<Content: View>(
    _ modifiers: [DynamicElementModifierNode],
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.init(
      ArraySlice(modifiers),
      content: content
    )
  }
  
  init<Content: View>(
    _ modifiers: ArraySlice<DynamicElementModifierNode>,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = { AnyView(content()) }
    self.modifiers = modifiers
  }
  
  var modifiers: ArraySlice<DynamicElementModifierNode>
  var content: () -> AnyView
  
  @ViewBuilder
  var body: some View {
    if modifiers.isEmpty {
      content()
    } else {
      DynamicModifiersView(
        modifiers.dropFirst()
      ) {
        DynamicModifierView(modifiers.first) {
          content()
        }
      }
    }
  }
}

struct DynamicModifierView<Content: View>: View {
  init(
    _ modifier: DynamicElementModifierNode? = nil,
    content: @escaping () -> Content
  ) {
    self.modifier = modifier
    self.content = content
  }
  
  var modifier: DynamicElementModifierNode?
  var content: () -> Content
  
  @ViewBuilder
  var body: some View {
    switch modifier {
    case let .padding(parameters):
      content().applying(parameters)
    case let .cornerRadius(parameters):
      content().applying(parameters)
    case let .backgroundColor(parameters):
      content().applying(parameters)
    case let .foregroundColor(parameters):
      content().applying(parameters)
    case .none:
      content()
    }
  }
}
