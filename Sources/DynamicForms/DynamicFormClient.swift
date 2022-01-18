import Foundation
import Combine
import Prelude

public struct DynamicFormClient {
  public init() {
    self.init(PassthroughSubject<AnyHashable, Never>())
  }
  
  public init<S: Subject>(_ subject: S)
  where S.Output == AnyHashable, S.Failure == Never {
    self.init(
      send: .init(subject.send),
      publisher: subject.eraseToAnyPublisher()
    )
  }
  
  public init(
    send: DynamicFormClient.Operations.SendEvent,
    publisher: AnyPublisher<AnyHashable, Never>
  ) {
    self.send = send
    self.publisher = publisher
  }
  
  public var send: Operations.SendEvent
  public var publisher: AnyPublisher<AnyHashable, Never>
  
  public func publisher(for actionID: AnyHashable) -> AnyPublisher<Void, Never> {
    return publisher
      .compactMap { receivedActionID in
        equal(receivedActionID, actionID) ? () : nil
      }
      .eraseToAnyPublisher()
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
    public typealias Input = AnyHashable
    public typealias Output = Void
    
    public init(_ call: @escaping Signature) {
      self.call = call
    }
    
    public var call: Signature
  }
}
