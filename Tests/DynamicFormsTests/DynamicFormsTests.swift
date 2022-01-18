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
    let expected = DynamicElementNode.primitive(.stack(
      DynamicStack(
        .vertical,
        id: actual.primitive?.stack?.id ?? UUID(),
        storage: .group([
          .primitive(.stack(
            DynamicStack(
              .horizontal,
              id: actual.primitive?.stack?.children[0].primitive?.stack?.id ?? UUID(),
              storage: .group([
                .primitive(.text(DynamicText("Hello"))),
                .primitive(.text(DynamicText("World")))
              ])
            )
          )),
          .primitive(.stack(
            DynamicStack(
              .horizontal,
              id: actual.primitive?.stack?.children[1].primitive?.stack?.id ?? UUID(),
              storage: .group([
                .primitive(.text(DynamicText("Hello"))),
                .primitive(.text(DynamicText("World")))
              ])
            )
          ))
        ])
      )
    ))
    
    XCTAssertEqual(actual, expected)
  }
}
