import Foundation

public struct _DynamicTupleElement: DynamicElement {
  public var content: Never { fatalError() }
  public var elements: [AnyDynamicElement]
  
  public var node: DynamicElementNode {
    get { .group(elements.map(\.node)) }
  }
  
  public init<
    T0: DynamicElement
  >(
    _ t0: T0
  ) {
    self.elements = [
      AnyDynamicElement(t0)
    ]
  }
  
  public init<
    T0: DynamicElement,
    T1: DynamicElement
  >(
    _ t0: T0,
    _ t1: T1
  ) {
    self.elements = [
      AnyDynamicElement(t0),
      AnyDynamicElement(t1)
    ]
  }
  
  public init<
    T0: DynamicElement,
    T1: DynamicElement,
    T2: DynamicElement
  >(
    _ t0: T0,
    _ t1: T1,
    _ t2: T2
  ) {
    self.elements = [
      AnyDynamicElement(t0),
      AnyDynamicElement(t1),
      AnyDynamicElement(t2)
    ]
  }
  
  public init<
    T0: DynamicElement,
    T1: DynamicElement,
    T2: DynamicElement,
    T3: DynamicElement
  >(
    _ t0: T0,
    _ t1: T1,
    _ t2: T2,
    _ t3: T3
  ) {
    self.elements = [
      AnyDynamicElement(t0),
      AnyDynamicElement(t1),
      AnyDynamicElement(t2),
      AnyDynamicElement(t3)
    ]
  }
  
  public init<
    T0: DynamicElement,
    T1: DynamicElement,
    T2: DynamicElement,
    T3: DynamicElement,
    T4: DynamicElement
  >(
    _ t0: T0,
    _ t1: T1,
    _ t2: T2,
    _ t3: T3,
    _ t4: T4
  ) {
    self.elements = [
      AnyDynamicElement(t0),
      AnyDynamicElement(t1),
      AnyDynamicElement(t2),
      AnyDynamicElement(t3),
      AnyDynamicElement(t4)
    ]
  }
  
  public init<
    T0: DynamicElement,
    T1: DynamicElement,
    T2: DynamicElement,
    T3: DynamicElement,
    T4: DynamicElement,
    T5: DynamicElement
  >(
    _ t0: T0,
    _ t1: T1,
    _ t2: T2,
    _ t3: T3,
    _ t4: T4,
    _ t5: T5
  ) {
    self.elements = [
      AnyDynamicElement(t0),
      AnyDynamicElement(t1),
      AnyDynamicElement(t2),
      AnyDynamicElement(t3),
      AnyDynamicElement(t4),
      AnyDynamicElement(t5)
    ]
  }
  
  public init<
    T0: DynamicElement,
    T1: DynamicElement,
    T2: DynamicElement,
    T3: DynamicElement,
    T4: DynamicElement,
    T5: DynamicElement,
    T6: DynamicElement
  >(
    _ t0: T0,
    _ t1: T1,
    _ t2: T2,
    _ t3: T3,
    _ t4: T4,
    _ t5: T5,
    _ t6: T6
  ) {
    self.elements = [
      AnyDynamicElement(t0),
      AnyDynamicElement(t1),
      AnyDynamicElement(t2),
      AnyDynamicElement(t3),
      AnyDynamicElement(t4),
      AnyDynamicElement(t5),
      AnyDynamicElement(t6)
    ]
  }
  
  public init<
    T0: DynamicElement,
    T1: DynamicElement,
    T2: DynamicElement,
    T3: DynamicElement,
    T4: DynamicElement,
    T5: DynamicElement,
    T6: DynamicElement,
    T7: DynamicElement
  >(
    _ t0: T0,
    _ t1: T1,
    _ t2: T2,
    _ t3: T3,
    _ t4: T4,
    _ t5: T5,
    _ t6: T6,
    _ t7: T7
  ) {
    self.elements = [
      AnyDynamicElement(t0),
      AnyDynamicElement(t1),
      AnyDynamicElement(t2),
      AnyDynamicElement(t3),
      AnyDynamicElement(t4),
      AnyDynamicElement(t5),
      AnyDynamicElement(t6),
      AnyDynamicElement(t7)
    ]
  }
  
  public init<
    T0: DynamicElement,
    T1: DynamicElement,
    T2: DynamicElement,
    T3: DynamicElement,
    T4: DynamicElement,
    T5: DynamicElement,
    T6: DynamicElement,
    T7: DynamicElement,
    T8: DynamicElement
  >(
    _ t0: T0,
    _ t1: T1,
    _ t2: T2,
    _ t3: T3,
    _ t4: T4,
    _ t5: T5,
    _ t6: T6,
    _ t7: T7,
    _ t8: T8
  ) {
    self.elements = [
      AnyDynamicElement(t0),
      AnyDynamicElement(t1),
      AnyDynamicElement(t2),
      AnyDynamicElement(t3),
      AnyDynamicElement(t4),
      AnyDynamicElement(t5),
      AnyDynamicElement(t6),
      AnyDynamicElement(t7),
      AnyDynamicElement(t8)
    ]
  }
  
  public init<
    T0: DynamicElement,
    T1: DynamicElement,
    T2: DynamicElement,
    T3: DynamicElement,
    T4: DynamicElement,
    T5: DynamicElement,
    T6: DynamicElement,
    T7: DynamicElement,
    T8: DynamicElement,
    T9: DynamicElement
  >(
    _ t0: T0,
    _ t1: T1,
    _ t2: T2,
    _ t3: T3,
    _ t4: T4,
    _ t5: T5,
    _ t6: T6,
    _ t7: T7,
    _ t8: T8,
    _ t9: T9
  ) {
    self.elements = [
      AnyDynamicElement(t0),
      AnyDynamicElement(t1),
      AnyDynamicElement(t2),
      AnyDynamicElement(t3),
      AnyDynamicElement(t4),
      AnyDynamicElement(t5),
      AnyDynamicElement(t6),
      AnyDynamicElement(t7),
      AnyDynamicElement(t8),
      AnyDynamicElement(t9)
    ]
  }
}
