import Foundation
import Combine
import Prelude

public struct DynamicFormClient {
  public init() {
    self.init(PassthroughSubject<Event, Never>())
  }
  
  public init<S: Subject>(_ subject: S)
  where S.Output == Event, S.Failure == Never {
    self.init(
      send: .init(subject.send),
      publisher: subject.eraseToAnyPublisher()
    )
  }
  
  public init(
    send: DynamicFormClient.Operations.SendEvent,
    publisher: AnyPublisher<Event, Never>
  ) {
    self.send = send
    self.publisher = publisher
  }
  
  public var send: Operations.SendEvent
  public var publisher: AnyPublisher<Event, Never>
  
  public func publisher(for event: Event) -> AnyPublisher<Void, Never> {
    return publisher
      .compactMap { receivedEvent in
        equal(receivedEvent, event) ? () : nil
      }
      .eraseToAnyPublisher()
  }
  
  public func publisher(for action: DynamicElementActionIdentifier) -> AnyPublisher<Void, Never> {
    return publisher
      .compactMap { receivedEvent in
        equal(receivedEvent.action, action) ? () : nil
      }
      .eraseToAnyPublisher()
  }
}

extension DynamicFormClient {
  public struct Event: Equatable, Hashable {
    public init(
      id: DynamicElementIdentifier,
      action: DynamicElementActionIdentifier
    ) {
      self.id = id
      self.action = action
    }
    
    public var id: DynamicElementIdentifier
    public var action: DynamicElementActionIdentifier
  }
}

extension DynamicFormClient {
  public static let shared: DynamicFormClient = .init()
}

extension DynamicFormClient {
  public enum Operations {}
}

extension DynamicFormClient.Operations {
  public struct SendEvent: Function {
    public typealias Input = DynamicFormClient.Event
    public typealias Output = Void
    
    public init(_ call: @escaping Signature) {
      self.call = call
    }
    
    public var call: Signature
  }
}
