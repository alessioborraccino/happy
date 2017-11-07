//
//  Enemy.swift
//  happy
//
//  Created by Alessio Borraccino on 26/12/2016.
//  Copyright © 2016 Gambero. All rights reserved.
//

import SpriteKit

class Enemy {
    
    let node : SKShapeNode
    
    init() {
        var points = [CGPoint(x: 0, y: 0),
                      CGPoint(x: 0 + 20, y: 0),
                      CGPoint(x: 0 + 10, y: 0 + 30),
                      CGPoint(x: 0, y: 0)]
        
        let triangle = SKShapeNode(points: &points, count: 4)
        triangle.lineWidth = 1
        triangle.strokeColor = UIColor.yellow
        triangle.fillColor = UIColor.yellow
        self.node = triangle
    }
}
