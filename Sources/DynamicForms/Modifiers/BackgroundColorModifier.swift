import GenericColor

extension DynamicElement {
  public func backgroundColor(
    _ color: Color<RGB>
  ) -> some DynamicElement {
    return modifier(
      DynamicElementModifiers.BackgroundColor(
        color
      )
    )
  }
}


extension DynamicElementModifiers {
  public struct BackgroundColor: DynamicElementModifier {
    public init(_ color: Color<RGB>) {
      self.color = color
    }
    
    public var color: Color<RGB>
    
    public var node: DynamicElementModifierNode {
      .backgroundColor(self)
    }
    
    public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      self.init(try container.decode(_ColorCodingContainer.self).color)
    }
    
    public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      try container.encode(_ColorCodingContainer(color))
    }
  }
}
