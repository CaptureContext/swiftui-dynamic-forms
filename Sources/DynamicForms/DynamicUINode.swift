import CasePaths
import Prelude

public indirect enum DynamicUINode: Equatable, Identifiable {
  case button(DynamicButton)
  case stack(DynamicStack)
  case text(DynamicText)
  //    case textInput(DynamicTextInput)
  
  public var id: AnyHashable {
    switch self {
    case let .button(state): return state.id
    case let .stack(state): return state.id
    case let .text(state): return state.id
    }
  }
  
  public var button: DynamicButton? {
    get { (/Self.button).extract(from: self) }
    set { (/Self.button).ifCaseLetEmbed(newValue, in: &self) }
  }
  
  public var stack: DynamicStack? {
    get { (/Self.stack).extract(from: self) }
    set { (/Self.stack).ifCaseLetEmbed(newValue, in: &self) }
  }
  
  public var text: DynamicText? {
    get { (/Self.text).extract(from: self) }
    set { (/Self.text).ifCaseLetEmbed(newValue, in: &self) }
  }
}
