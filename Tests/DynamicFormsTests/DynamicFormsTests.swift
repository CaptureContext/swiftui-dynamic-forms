import XCTest
@testable import DynamicForms
import CustomDump
import GenericColor

final class DynamicFormsTests: XCTestCase {
  func testExample() throws {
    struct SomeComponent: DynamicElement {
      var content: some DynamicElement {
        DynamicStack(
          .horizontal,
          content: {
            DynamicText("Hello")
              .foregroundColor(.hex("#FFAA00")!)
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
    let parentStackID = actual.primitive?.node.stack?.id ?? .uuid()
    let childStack1ID = actual.primitive?.node.stack?.children[0]
      .primitive?.node.stack?.id ?? .uuid()
    let childStack2ID = actual.primitive?.node.stack?.children[1]
      .primitive?.node.stack?.id ?? .uuid()
    let expected = DynamicElementNode.primitive(.init(.stack(
      DynamicStack(
        .vertical,
        id: parentStackID,
        storage: .group(.init([
          .primitive(.init(.stack(
            DynamicStack(
              .horizontal,
              id: childStack1ID,
              storage: .group(.init([
                .primitive(.init(
                  .text(DynamicText("Hello")),
                  modifiers: [
                    .foregroundColor(.init(.hex("#FFAA00")!))
                  ]
                )),
                .primitive(.init(
                  .text(DynamicText("World"))
                ))
              ]))
            )
          ))),
          .primitive(.init(.stack(
            DynamicStack(
              .horizontal,
              id: childStack2ID,
              storage: .group(.init([
                .primitive(.init(
                  .text(DynamicText("Hello")),
                  modifiers: [
                    .foregroundColor(.init(.hex("#FFAA00")!))
                  ]
                )),
                .primitive(.init(
                  .text(DynamicText("World"))
                ))
              ]))
            )
          )))
        ]))
      )
    )))
    
    XCTAssertEqual(actual, expected)
  }
  
  func testModifiers() {
    let id: DynamicElementIdentifier = "text"
    let actual = DynamicText(
      "Hello",
      id: id
    )
      .padding(.vertical, 12)
      .padding(.horizontal, 24)
      .backgroundColor(.hex("#FF0000")!)
      .foregroundColor(.hex("#FFFFFF")!)
      .cornerRadius(8, style: .continouos)
      .node
    
    let expected = DynamicElementNode.primitive(.init(
      .text(DynamicText("Hello", id: id)),
      modifiers: [
        .padding(.init(.vertical, 12)),
        .padding(.init(.horizontal, 24)),
        .backgroundColor(.init(.hex("#FF0000")!)),
        .foregroundColor(.init(.hex("#FFFFFF")!)),
        .cornerRadius(.init(8, style: .continouos))
      ]
    ))
    
    XCTAssertEqual(actual, expected)
  }
}
