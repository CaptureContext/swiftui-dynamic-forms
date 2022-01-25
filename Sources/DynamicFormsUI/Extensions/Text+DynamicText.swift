import SwiftUI
import DynamicForms

extension DynamicText.AccessibilityTextContentType {
  #if compiler(>=5.5.1)
  @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
  var toSwiftUI: SwiftUI.AccessibilityTextContentType {
    switch self {
    case .console: return .console
    case .fileSystem: return .fileSystem
    case .messaging: return .messaging
    case .narrative: return .narrative
    case .plain: return .plain
    case .sourceCode: return .sourceCode
    case .spreadsheet: return .spreadsheet
    case .wordProcessing: return .wordProcessing
    }
  }
  #endif
}

extension DynamicText.AccessibilityHeadingLevel {
  #if compiler(>=5.5.1)
  @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
  var toSwiftUI: SwiftUI.AccessibilityHeadingLevel {
    switch self {
    case .h1: return .h1
    case .h2: return .h2
    case .h3: return .h3
    case .h4: return .h4
    case .h5: return .h5
    case .h6: return .h6
    case .unspecified: return .unspecified
    }
  }
  #endif
}

extension Text {
  public init(_ state: DynamicText) {
    let text: Text
    switch state.storage {
    case let .concatenated(first, second):
      text = Text(first) + Text(second)
    case let .localized(content, tableName, bundle, comment):
      text = .init(content, tableName: tableName, bundle: bundle, comment: comment)
    case let .verbatim(content):
      text = .init(verbatim: content)
    }
    self = state.modifiers.reduce(text) { text, modifier in
      switch modifier {
#if compiler(>=5.5.1)
      case let .accessibilityHeading(level):
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
          return text.accessibilityHeading(level.toSwiftUI)
        } else {
          return text
        }
      case let .accessibilityLabel(value):
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
          switch value.storage {
          case let .verbatim(string):
            return text.accessibilityLabel(string)
          case let .localized(key, tableName, bundle, comment):
            return text.accessibilityLabel(
              Text(key, tableName: tableName, bundle: bundle, comment: comment))
          case .concatenated(_, _):
            assertionFailure("`.accessibilityLabel` does not support contcatenated `DynamicText`")
            return text
          }
        } else {
          return text
        }
      case let .accessibilityTextContentType(type):
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
          return text.accessibilityTextContentType(type.toSwiftUI)
        } else {
          return text
        }
#else
      case .accessibilityHeading,
          .accessibilityLabel,
          .accessibilityTextContentType:
        return text
#endif
      case let .baselineOffset(baselineOffset):
        return text.baselineOffset(baselineOffset)
      case .bold:
        return text.bold()
      case let .font(font):
        return text.font(font)
      case let .fontWeight(weight):
        return text.fontWeight(weight)
      case let .foregroundColor(color):
        return text.foregroundColor(color)
      case .italic:
        return text.italic()
      case let .kerning(kerning):
        return text.kerning(kerning)
      case let .strikethrough(active, color):
        return text.strikethrough(active, color: color)
      case let .tracking(tracking):
        return text.tracking(tracking)
      case let .underline(active, color):
        return text.underline(active, color: color)
      }
    }
  }
}
