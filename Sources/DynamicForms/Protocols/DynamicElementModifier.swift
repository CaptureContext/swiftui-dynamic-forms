public protocol DynamicElementModifier: Equatable, Codable {
  var node: DynamicElementModifierNode { get }
}

extension DynamicElement {
  public func modifier<
    Modifier: DynamicElementModifier
  >(_ modifier: Modifier) -> some DynamicElement {
    var node = self.node
    node.modifiers.append(modifier.node)
    return ModifiedDynamicElement(node)
  }
}
