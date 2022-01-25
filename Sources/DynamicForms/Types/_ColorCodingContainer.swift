import GenericColor

public struct _ColorCodingContainer: Equatable, Codable {
  public init(
    _ color: Color<RGB>
  ) {
    self.color = color
  }
  
  var color: Color<RGB>
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let color = try container.decode(CodingContainer.self)
    self.init(
      Color<RGB>.init(
        red: .init(floatLiteral: color.red),
        green: .init(floatLiteral: color.green),
        blue: .init(floatLiteral: color.blue),
        alpha: .init(floatLiteral: color.alpha)
      )
    )
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    let color = CodingContainer(
      red: color.red.doubleValue,
      green: color.green.doubleValue,
      blue: color.blue.doubleValue,
      alpha: color.alpha.doubleValue
    )
    try container.encode(color)
  }
  
  struct CodingContainer: Codable {
    enum CodingKeys: CodingKey {
      case red
      case green
      case blue
      case alpha
    }
    
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
    
    init(red: Double, green: Double, blue: Double, alpha: Double) {
      self.red = red
      self.green = green
      self.blue = blue
      self.alpha = alpha
    }
    
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.init(
        red: try container.decode(Double.self, forKey: .red),
        green: try container.decode(Double.self, forKey: .green),
        blue: try container.decode(Double.self, forKey: .blue),
        alpha: try container.decode(Double.self, forKey: .alpha)
      )
    }
    
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(red, forKey: .red)
      try container.encode(green, forKey: .green)
      try container.encode(blue, forKey: .blue)
      try container.encode(alpha, forKey: .alpha)
    }
  }
  }
