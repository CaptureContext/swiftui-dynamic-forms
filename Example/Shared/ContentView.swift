//
//  ContentView.swift
//  Shared
//
//  Created by Maxim Krouk on 15.01.22.
//

import SwiftUI
import DynamicFormsUI

struct ContentView: View {
  @State
  var form = DynamicForm {
    DynamicStack(.vertical) {
      DynamicText("Title").bold()
      DynamicText("Description")
      DynamicStack(.horizontal) {
        DynamicText("State: ")
        DynamicText("Initial", id: "text.state")
      }
      .padding()
      DynamicStack(.horizontal) {
        DynamicButton(action: "content.ok") {
          DynamicText("OK")
            .padding(.vertical, 6)
            .padding(.horizontal, 24)
        }
        .foregroundColor(.hex("#000000")!)
        .backgroundColor(.hex("#00FF00")!)
        .cornerRadius(5, style: .continouos)
        DynamicButton(action: "content.cancel") {
          DynamicText("Cancel")
            .padding(.vertical, 6)
            .padding(.horizontal)
        }
        .foregroundColor(.hex("#ffffff")!)
        .backgroundColor(.hex("#ff0000")!)
        .cornerRadius(5, style: .continouos)
        DynamicToggle(id: "toggle.state", value: false)
      }
    }
  }
  
  @State
  var actionMessages: [String] = []
  
  var body: some View {
    ZStack {
      DynamicViews.Form($form)
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
      form.content.node[id: "text.state"]?.text = DynamicText("ok", id: "text.state").bold()
      form.content.node[id: "toggle.state"]?.toggle?.value = true
      printMessage("OK")
    }
    .onReceive(
      DynamicFormClient.shared.publisher(for: "content.cancel")
    ) {
      form.content.node[id: "text.state"]?.text = DynamicText("cancel", id: "text.state").bold()
      form.content.node[id: "toggle.state"]?.toggle?.value = false
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
