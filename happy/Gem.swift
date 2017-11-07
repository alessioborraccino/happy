//
//  GameModel.swift
//  happy
//
//  Created by Alessio Borraccino on 26/12/2016.
//  Copyright © 2016 Gambero. All rights reserved.
//

import SpriteKit

enum GemShape {
    case square
    case circle
}
extension UIColor {
    var collisionCategory : String? {
        switch self {
        case UIColor.red:
            return "red"
        case UIColor.yellow:
            return "yellow"
        case UIColor.purple:
            return "purple"
        default:
            return nil
        }
    }
}

struct GemConfiguration {
    let color : UIColor
    let shape : GemShape
    let size  : CGFloat
    
    static var null : GemConfiguration {
        return GemConfiguration(color: .red, shape: .circle, size: 10)
    }
    static var moving : GemConfiguration {
        return GemConfiguration(color: .purple, shape: .square, size: 20)
    }
    static var bonus : GemConfiguration {
        return GemConfiguration(color: .yellow, shape: .square, size: 20)
    }
}

class Gem {
    
    let node : SKShapeNode
    
    init(configuration: GemConfiguration) {
        switch configuration.shape {
        case .square:
            self.node = SKShapeNode(rectOf: CGSize(width: configuration.size, height: configuration.size))
        case .circle:
            self.node = SKShapeNode(circleOfRadius: configuration.size)
        }
        node.strokeColor = configuration.color
        node.glowWidth = 0.5
        node.lineWidth = 0.5
        node.physicsBody?.applyForce(CGVector(dx: 2, dy: 0))
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: configuration.size, height: configuration.size))
        node.physicsBody?.mass = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
