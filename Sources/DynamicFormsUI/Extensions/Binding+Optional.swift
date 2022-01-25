import SwiftUI

extension Binding {
  func optionalMap<Wrapped, LocalValue>(
    _ keyPath: WritableKeyPath<Wrapped, Optional<LocalValue>>
  ) -> Binding<Optional<LocalValue>> where Value == Optional<Wrapped> {
    return Binding<Optional<LocalValue>>(
      get: { self.wrappedValue?[keyPath: keyPath] },
      set: {
        if let value = $0 {
          self.wrappedValue?[keyPath: keyPath] = value
        }
      }
    )
  }
  
  func optionalValueMap<LocalValue>(
    _ keyPath: WritableKeyPath<Value, Optional<LocalValue>>
  ) -> Binding<Optional<LocalValue>> {
    return Binding<Optional<LocalValue>>(
      get: { self.wrappedValue[keyPath: keyPath] },
      set: {
        if let value = $0 {
          self.wrappedValue[keyPath: keyPath] = value
        }
      }
    )
  }
  
  func optionalRootMap<Wrapped, LocalValue>(
    _ keyPath: WritableKeyPath<Wrapped, LocalValue>
  ) -> Binding<LocalValue?> where Value == Optional<Wrapped> {
    return Binding<LocalValue?>(
      get: { self.wrappedValue?[keyPath: keyPath] },
      set: {
        if let value = $0 {
          self.wrappedValue?[keyPath: keyPath] = value
        }
      }
    )
  }
  
  public func optional() -> Binding<Value?> {
    return Binding<Value?>(
      get: { self.wrappedValue },
      set: { $0.map { self.wrappedValue = $0 } }
    )
  }
  
  func or<Wrapped>(_ value: @escaping @autoclosure () -> Wrapped) -> Binding<Wrapped>
  where Value == Optional<Wrapped> {
    return Binding<Wrapped>(
      get: { self.wrappedValue ?? value() },
      set: { self.wrappedValue = $0 }
    )
  }
}
