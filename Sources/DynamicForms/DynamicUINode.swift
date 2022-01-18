import CasePaths
import Prelude

public indirect enum DynamicUINode: Equatable, Identifiable {
  case button(DynamicButton)
  case spacer(DynamicSpacer)
  case stack(DynamicStack)
  case text(DynamicText)
  case textField(DynamicTextField)
  case textView(DynamicTextView)
}

extension DynamicUINode {
  public var id: DynamicElementIdentifier {
    switch self {
    case let .button(state): return state.id
    case let .spacer(state): return state.id
    case let .stack(state): return state.id
    case let .text(state): return state.id
    case let .textField(state): return state.id
    case let .textView(state): return state.id
    }
  }
  
  public var spacer: DynamicSpacer? {
    get { (/Self.spacer).extract(from: self) }
    set { (/Self.spacer).ifCaseLetEmbed(newValue, in: &self) }
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
  
  public var textField: DynamicTextField? {
    get { (/Self.textField).extract(from: self) }
    set { (/Self.textField).ifCaseLetEmbed(newValue, in: &self) }
  }
  
  public var textView: DynamicTextView? {
    get { (/Self.textView).extract(from: self) }
    set { (/Self.textView).ifCaseLetEmbed(newValue, in: &self) }
  }
}
