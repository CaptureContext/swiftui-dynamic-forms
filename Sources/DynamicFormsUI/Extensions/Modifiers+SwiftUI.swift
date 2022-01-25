import SwiftUI
import DynamicForms

extension SwiftUI.Edge.Set {
  init(_ edges: DynamicElementModifiers.Padding.Edge.Set) {
    var value: SwiftUI.Edge.Set = []
    
    if edges.contains(.top) { value.insert(.top) }
    if edges.contains(.bottom) { value.insert(.bottom) }
    if edges.contains(.leading) { value.insert(.leading) }
    if edges.contains(.trailing) { value.insert(.trailing) }
    
    self = value
  }
}

extension RoundedCornerStyle {
  init(_ style: DynamicElementModifiers.CornerRadius.Style) {
    switch style {
    case .circular:
      self = .circular
    case .continouos:
      self = .continuous
    }
  }
}

extension View {
  public func applying(
    _ padding: DynamicElementModifiers.Padding
  ) -> some View {
    self.padding(.init(padding.edges), CGFloat(padding.value))
  }
  
  public func applying(
    _ cornerRadius: DynamicElementModifiers.CornerRadius
  ) -> some View {
    self.clipShape(
      RoundedRectangle(
        cornerRadius: cornerRadius.value,
        style: .init(cornerRadius.style)
      )
    )
  }
  
  public func applying(
    _ backgroundColor: DynamicElementModifiers.BackgroundColor
  ) -> some View {
    self.background(Color(backgroundColor.color))
  }
  
  public func applying(
    _ foregroundColor: DynamicElementModifiers.ForegroundColor
  ) -> some View {
    self.foregroundColor(Color(foregroundColor.color))
  }
}
