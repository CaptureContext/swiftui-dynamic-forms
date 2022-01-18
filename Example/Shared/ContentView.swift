//
//  ContentView.swift
//  Shared
//
//  Created by Maxim Krouk on 15.01.22.
//

import SwiftUI
import DynamicForms

struct ContentView: View {
  @State
  var form = DynamicForm {
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
  
  @State
  var actionMessages: [String] = []
  
  var body: some View {
    ZStack {
      DynamicFormView($form)
      VStack {
        Spacer()
        ScrollView(.vertical, showsIndicators: false) {
          VStack {
            ForEach(actionMessages, id: \.self) { message in
              Text(message)
                .rotationEffect(.radians(.pi))
            }
          }
          .padding(.top)
          .frame(maxWidth: .infinity)
        }
        .rotationEffect(.radians(.pi))
        .frame(height: 100)
      }
    }
    .onReceive(
      DynamicFormClient.shared.publisher(for: "content.ok")
    ) {
      form.node.stack?.children[2].primitive?.stack?.children[1].primitive?.text = DynamicText("ok").bold()
      printMessage("OK")
    }
    .onReceive(
      DynamicFormClient.shared.publisher(for: "content.cancel")
    ) {
      form.node.stack?.children[2].primitive?.stack?.children[1].primitive?.text = DynamicText("cancel").bold()
      printMessage("CANCEL")
    }
  }
  
  func printMessage(_ text: String) {
    actionMessages.insert(text, at: 0)
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
      _ = actionMessages.popLast()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
