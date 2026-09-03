import XCTest
@testable import DynamicForms
import CustomDump

final class DynamicFormsTests: XCTestCase {
  func testExample() throws {
    struct SomeComponent: DynamicElement {
      var content: some DynamicElement {
        DynamicStack(
          .horizontal,
          content: {
            DynamicText("Hello")
            DynamicText("World")
          }
        )
      }
    }
    
    struct SomeComponent1: DynamicElement {
      var content: some DynamicElement {
        DynamicStack(
          .vertical,
          content: {
            SomeComponent()
            SomeComponent()
          }
        )
      }
    }
    
    let actual = SomeComponent1().node
    func text(
      _ value: String,
      id: DynamicElementIdentifier?
    ) -> DynamicText {
      var text = DynamicText(value)
      text.id = id ?? .uuid()
      return text
    }
    let firstStack = actual.primitive?.stack?.children[0].primitive?.stack
    let secondStack = actual.primitive?.stack?.children[1].primitive?.stack
    let expected = DynamicElementNode.primitive(.stack(
      DynamicStack(
        .vertical,
        id: actual.primitive?.stack?.id ?? .uuid(),
        storage: .group([
          .primitive(.stack(
            DynamicStack(
              .horizontal,
              id: firstStack?.id ?? .uuid(),
              storage: .group([
                .primitive(.text(text("Hello", id: firstStack?.children[0].primitive?.text?.id))),
                .primitive(.text(text("World", id: firstStack?.children[1].primitive?.text?.id)))
              ])
            )
          )),
          .primitive(.stack(
            DynamicStack(
              .horizontal,
              id: secondStack?.id ?? .uuid(),
              storage: .group([
                .primitive(.text(text("Hello", id: secondStack?.children[0].primitive?.text?.id))),
                .primitive(.text(text("World", id: secondStack?.children[1].primitive?.text?.id)))
              ])
            )
          ))
        ])
      )
    ))
    
    XCTAssertEqual(actual, expected)
  }
}
