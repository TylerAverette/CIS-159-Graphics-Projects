//
//  GameScene.swift
//  MyFirstGame
//
//  Created by Student User on 9/18/19.
//  Copyright © 2019 Student User. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
//    private var ball : SKSpriteNode?
    private var girl: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        for i in 0...9{
        let ball = SKSpriteNode(imageNamed: "football")
//        guard let ball = self.ball else {return}
        ball.name = "ball \(i)"
        self.addChild(ball)
        ball.run(SKAction.sequence([
                 SKAction.group([
                 SKAction.resize(toHeight: 130, duration: 1),
                 SKAction.resize(toWidth: 130, duration: 1),
                 ]),
                 SKAction.move(to: CGPoint(x:130+i*5, y:130+i*5), duration: 1),
                 SKAction.move(by: CGVector(dx: 13, dy: 13), duration: 1),
                 SKAction.moveBy(x: -200, y: -13, duration: 1),
                 SKAction.move(to: CGPoint(x: i*5, y: i*5), duration: 1),
                 SKAction.rotate(byAngle: CGFloat.pi * CGFloat(i), duration: 1),
//                 SKAction.resize(toHeight: 13, duration: 1),
                ]))
        }
        
        
//        ball.run(SKAction.resize(toWidth: 200, height: 200, duration: 1))
        
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        let ball = self.atPoint(pos)
        
        guard let name = ball.name else {return}
        
        ball.run(SKAction.move(by: CGVector(dx: 0, dy: 200), duration: 1))
//        guard node = touchednode else {return}
        
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
        guard let rainNode = SKEmitterNode(fileNamed: "Rain.sks") else{
            print("Fatal error occured")
            return;
        }
        rainNode.position = pos
        self.addChild(rainNode)
        
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
