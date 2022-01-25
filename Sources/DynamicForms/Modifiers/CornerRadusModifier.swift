extension DynamicElement {
  public func cornerRadius(
    _ value: Double,
    style: DynamicElementModifiers.CornerRadius.Style
  ) -> some DynamicElement {
    return modifier(
      DynamicElementModifiers.CornerRadius(
        value,
        style: style
      )
    )
  }
}


extension DynamicElementModifiers {
  public struct CornerRadius: DynamicElementModifier {
    public enum Style: String, Equatable, RawCodable {
      case circular
      case continouos
    }
    
    public init(
      _ value: Double,
      style: Style
    ) {
      self.value = value
      self.style = style
    }
    
    public var value: Double
    public var style: Style
    
    public var node: DynamicElementModifierNode {
      .cornerRadius(self)
    }
  }
}
