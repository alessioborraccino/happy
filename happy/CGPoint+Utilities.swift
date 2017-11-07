//
//  CGPoint+Utilities.swift
//  happy
//
//  Created by Alessio Borraccino on 23/12/2016.
//  Copyright © 2016 Gambero. All rights reserved.
//

import Foundation 
import UIKit

extension CGFloat {
    static func random(between min: CGFloat, and max: CGFloat) -> CGFloat {
        let randomFloat = CGFloat(Double(arc4random())/Double(UInt32.max))
        return randomFloat * (max - min) + min
    }
}
extension CGPoint {
    func distanceTo(point: CGPoint) -> CGFloat {
        return CGFloat(hypotf(Float(point.x) - Float(self.x), Float(point.y) - Float(self.y)))
    }
    func adding(point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + point.x, y: self.y + point.y)
    }
}

extension CGRect {
    
    private enum RectEdge : Int {
        case left = 0
        case top = 1
        case right = 2
        case bottom = 3
    }
    func randomPointAtRandomEdge() -> CGPoint {
        let randomEdge = RectEdge(rawValue: Int(arc4random_uniform(4)))!
        return randomPoint(at: randomEdge)
    }
    
    private func randomPoint(at edge: RectEdge) -> CGPoint {
        switch edge {
        case .left:
            let otherCoordinate = CGFloat.random(between: self.minY, and: self.maxY)
            return CGPoint(x:self.minX, y: otherCoordinate)
        case .top:
            let otherCoordinate = CGFloat.random(between: self.minX, and: self.maxX)
            return CGPoint(x:otherCoordinate, y: self.minY)
        case .bottom:
            let otherCoordinate = CGFloat.random(between: self.minX, and: self.maxX)
            return CGPoint(x:otherCoordinate, y: self.maxY)
        case .right:
            let otherCoordinate = CGFloat.random(between: self.minY, and: self.maxY)
            return CGPoint(x:self.maxX, y: otherCoordinate)
        }
    }
}
