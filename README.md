# swiftui-dynamic-forms

> The package is early alpha (prototyping stage)
> Run `make workspace` from the terminal to generate `.xcworkspace` for the example



## TODO

- **Components**
  - [x] `DynamicText`
  - [x] `DynamicButton`
  - [x] `DynamicStack`
  - [x] `DynamicTextField`
  - [x] `DynamicTextView`
  - [x] `DynamicSpacer`
  - [ ] `DynamicImage`
  - [x] `DynamicToggle`
  - [ ] `DynamicImage`
  - [ ] `DynamicConfirmationDialog`
  - [ ] `DynamicAlert`
  - [ ] `DynamicDragField`
  - [ ] `DynamicDropField`
  - [ ] `DynamicLink`
  - [ ] `DynamicNavigationView`
- **Features**
  - [ ] Codable support
  - [ ] Remove SwiftUI Dependency
    - Create SwiftUI-independent DynamicText modifiers for `Color` and `Font`
  - [ ] Custom modifiers
- **To-think-about**
  - API improvements for state management
  - API improvements for action handling
  - Helper for derived (optional/collection) `Binding`s



## Usage

[**Example**](Example/Shared/ContentView.swift)

- Import `DynamicForms`

- Declare your dynamic form model

  ```swift
  DynamicForm {
    DynamicStack(.vertical) {
      DynamicText("Title").bold()
      DynamicText("Description")
      DynamicStack(.horizontal) {
        DynamicText("State: ")
        DynamicText("Initial")
      }
      DynamicStack(.horizontal) {
        DynamicButton(
          DynamicText("OK"),
          action: "content.ok"
        )
        DynamicButton(
          DynamicText("Cancel"),
          action: "content.cancel"
        )
      }
    }
  }
  ```

  > Equivalent for
  >
  > ```swift
  > VStack {
  >   Text("Title").bold()
  >   Text("Description")
  >   HStack {
  >     Text("State: ")
  >     Text("Initial")
  >   }
  >   HStack {
  >     Button { 
  >       DynamicFormClient.shared.send("content.id")
  >     } label: {
  >       Text("OK")
  >     }
  >     Button { 
  >       DynamicFormClient.shared.send("content.cancel")
  >     } label: {
  >       Text("Cancel")
  >     }
  >   }
  > }
  > ```

- Specify body for your dynamic-form-based view using `DynamicFormView`

  ```swift
  DynamicFormView($form)
  ```

- Handle button actions

  ```swift
  // Returns AnyPublisher<Event, Never> where Event is
  // Event {
  //   id: DynamicElementIdentifier
  //   action: DynamicElementActionIdentifier
  // }
  DynamicFormClient.shared.publisher
  
  // Filters events and returns AnyPublisher<Void, Never>
  DynamicFormClient.shared.publisher(
    for: .init(id: "element", action: "tap")
  )
  
  // Filters events by actionID and returns AnyPublisher<Void, Never>
  DynamicFormClient.shared.publisher(
    for: "actionID"
  )
  ```



## Installation

### Basic

You can add DynamicForms to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Swift Packages › Add Package Dependency…**
2. Enter [`"https://github.com/capturecontext/swiftui-dynamic-forms.git"`](https://github.com/capturecontext/swiftui-dynamic-forms.git) into the package repository URL text field
3. Choose products you need to link them to your project.

### Recommended

If you use SwiftPM for your project, you can add StandardClients to your package file.

```swift
.package(
  name: "swiftui-dynamic-forms",
  url: "https://github.com/capturecontext/swiftui-dynamic-forms.git", 
  .branch("0.1.0")
)
```

Do not forget about target dependencies:

```swift
.product(
  name: "DynamicFormss", 
  package: "swiftui-dynamic-forms"
)
```



## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
