//
//  GameScene.swift
//  happy
//
//  Created by Alessio Borraccino on 23/12/2016.
//  Copyright © 2016 Gambero. All rights reserved.
//

import GameKit

class GameScene: SKScene {

    fileprivate var maxGems : Int = 300
    fileprivate var enemySpeed: TimeInterval = 20
    
    fileprivate var gems: [Gem] = []
    fileprivate var enemies: [Enemy] = []
    
    static func make() -> GameScene {
        let gameScene = GameScene(fileNamed: "HappyScene.sks")
        gameScene?.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        gameScene?.scaleMode = .resizeFill
        return gameScene!
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    func touchDown(at point: CGPoint, force: CGFloat) {
        handleTouch(at: point)
    }
    func touchMoved(fromPoint: CGPoint, toPoint: CGPoint, force: CGFloat) {
        handleTouch(at: toPoint)
    }
    func touchUp(at point: CGPoint, force: CGFloat) {
        handleTouch(at: point)
    }
    private func isEnemy(at point: CGPoint) -> Bool {
        return !(nodes(at: point).filter({ (node) -> Bool in
            return node.name == "Enemy"
        }).isEmpty)
    }
    private func handleTouch(at point: CGPoint) {
        if isEnemy(at: point) {
            addGem(at: point, isNull: true)
        } else {
            addGem(at: point)
        }
    }
}

//MARK: Touch handling
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(at: t.location(in: self), force: t.force) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(fromPoint: t.previousLocation(in: self), toPoint: t.location(in: self), force: t.force) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(at: t.location(in: self), force: t.force) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(at: t.location(in: self), force: t.force) }
    }
}

extension GameScene {
    
    fileprivate func addEnemy(at position: CGPoint) {
        
        let enemy = Enemy()
        let enemyNode = enemy.node
        enemyNode.position = enemyNode.position.adding(point: position)
        let happyLabelCenter = childNode(withName: "HappyLabel")!
        let shipRotation = atan2(position.y, position.x) - atan2(happyLabelCenter.position.y, happyLabelCenter.position.x) + CGFloat(M_PI_2)
        enemyNode.zRotation = shipRotation
        let moveToCenterAction = SKAction.move(to: happyLabelCenter.position, duration: enemySpeed)
        enemyNode.run(moveToCenterAction) { [weak enemyNode] in
            let action = SKAction.fadeOut(withDuration: 0.3)
            enemyNode?.run(action, completion: {
                enemyNode?.removeFromParent()
            })
        }
        enemyNode.name = "Enemy"
        addChild(enemyNode)
        enemies.append(enemy)
    }
    fileprivate func makeGem(isNull: Bool) -> Gem {
        let gem: Gem
        if  isNull {
            gem = Gem(configuration: GemConfiguration.null)
        } else {
            let willBeBonus = arc4random_uniform(30) == 0
            gem = Gem(configuration: willBeBonus ? .bonus : .moving)
        }
        
        return gem
    }
    
    fileprivate func addGem(at position: CGPoint, isNull: Bool = false) {
        if gems.count >= maxGems {
            let node = gems.removeFirst().node
            let action = SKAction.fadeOut(withDuration: 0.3)
            node.run(action, completion: { [weak node] in
                node?.removeFromParent()
            })
        }
        let gem = makeGem(isNull: isNull)
        gem.node.position = position.adding(point: CGPoint(x: -10, y: -10))
        addChild(gem.node)
        gems.append(gem)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if currentTime.truncatingRemainder(dividingBy: 10) < 0.05 {
            addEnemy(at: frame.randomPointAtRandomEdge())
        }
    }
}
