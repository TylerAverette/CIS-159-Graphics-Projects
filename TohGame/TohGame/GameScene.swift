//
//  GameScene.swift
//  TohGame
//
//  Created by Student User on 9/30/19.
//  Copyright © 2019 Student User. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    class Tower {
        var array : [SKSpriteNode] = []
    }
    
    let discA = SKSpriteNode(imageNamed: "redDisc")
    let discB = SKSpriteNode(imageNamed: "pinkDisc")
    let discC = SKSpriteNode(imageNamed: "yellowDisc")
    let discD = SKSpriteNode(imageNamed: "grayDisc")
    let discE = SKSpriteNode(imageNamed: "brownDisc")
    let discF = SKSpriteNode(imageNamed: "greenDisc")
    let towerBaseImage1 = SKSpriteNode(imageNamed: "towerBaseImage")
    let towerBaseImage2 = SKSpriteNode(imageNamed: "towerBaseImage")
    let towerBaseImage3 = SKSpriteNode(imageNamed: "towerBaseImage")
    
    //var tower1Array: [SKSpriteNode] = [];
    //var tower2Array: [SKSpriteNode] = [];
    //var tower3Array: [SKSpriteNode] = [];
    var tower1 : Tower = Tower();
    var tower2 : Tower = Tower();
    var tower3 : Tower = Tower();
    
    var discYAxisValues: [CGFloat] = [];
    
    //var towers = [tower1Array, tower2Array, tower3Array]
    
    var towerBaseArray: [SKSpriteNode] = [];
    
    
    override func didMove(to view: SKView) {
        
        tower1.array = [discA, discB, discC, discD, discE, discF]
        towerBaseArray = [towerBaseImage1, towerBaseImage2, towerBaseImage3]
//        var towerXAxis = 55
//        let towerYAxis = 200
        let numDisc = tower1.array.count;
        let discHeight: CGFloat = 50
        let towerXAxis: CGFloat = -160
        let towerYAxis: CGFloat = -75
        let discXAxis: CGFloat = -160
        var discYAxis: CGFloat = -50
        var discWidth: CGFloat = 100
        var mutableDiscYAxis: CGFloat = -100
        
        
    
        //Draw disc
        for index in 0...numDisc-1{
            
            tower1.array[index].run(SKAction.resize(toWidth: discWidth, height: discHeight, duration: 0.1))
            tower1.array[index].run(SKAction.moveTo(y: discYAxis, duration: 0.01))
            tower1.array[index].run(SKAction.moveTo(x: discXAxis, duration: 0.01))
            discWidth = discWidth - 10
            discYAxis += 50
        }
        
        for _ in 0...numDisc{
            discYAxisValues.append(mutableDiscYAxis)
            mutableDiscYAxis += 50
        }
        
        // Draw towers
        
        for j in 0...2{
            towerBaseArray[j].run(SKAction.resize(toWidth: 150, duration: 0.01))
        }
        
        towerBaseArray[0].run(SKAction.moveTo(y: towerYAxis, duration: 0.01))
        towerBaseArray[0].run(SKAction.moveTo(x: towerXAxis, duration: 0.01))
        self.addChild(towerBaseArray[0])
        
        towerBaseArray[1].run(SKAction.moveTo(y: towerYAxis, duration: 0.01))
        towerBaseArray[1].run(SKAction.moveTo(x: towerXAxis-towerXAxis, duration: 0.01))
        self.addChild(towerBaseArray[1])
        
        towerBaseArray[2].run(SKAction.moveTo(y: towerYAxis, duration: 0.01))
        towerBaseArray[2].run(SKAction.moveTo(x: towerXAxis-towerXAxis*2, duration: 0.01))
        self.addChild(towerBaseArray[2])
        
        // Add Discs to view
        for i in 0...numDisc-1{
            self.addChild(tower1.array[i])
        }
    }
    
    var dragNode : SKSpriteNode?
    
    func touchDown(atPoint pos : CGPoint) {
//        guard dragNode != nil else {return}

        let node = self.atPoint(pos);
        print(tower1.array.count,tower2.array.count,tower3.array.count)
        print(tower1.array.last,tower2.array.last,tower3.array.last)
        if node is SKSpriteNode {
            if node == tower1.array.last || node == tower2.array.last || node == tower3.array.last {
                dragNode = node as? SKSpriteNode
            } else {
                print("no drag set")
                dragNode = nil
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let dragNode = dragNode {
            dragNode.run(SKAction.move(to: pos, duration: 0.01))
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        guard let _ = dragNode else {return}
        var target : Tower
        var source : Tower
        var sourceXcenter : CGFloat = 0

        if dragNode == tower1.array.last {
            source = tower1
            sourceXcenter = -160
        } else if dragNode == tower2.array.last {
            source = tower2
            sourceXcenter = 0
        } else if dragNode == tower3.array.last {
            source = tower3
            sourceXcenter = 160
        }
        else {
            print("bad dragNode")
            return;
        }
        
        var theXcenter : CGFloat = 0
        if pos.x < -52{
            target = tower1
            theXcenter = -160
            //            tower1Array.last?.run(SKAction.moveTo(x: CGFloat(tower1Array.count) * (dragNode?.frame.height)!, duration: 0.01))
        } else if pos.x > -52 && pos.x < 100{
            target = tower2
            theXcenter = 0;
        } else if pos.x > 100 {
            target = tower3
            theXcenter = 160;
        } else {
            print("bad target")
            return
        }

        if ( target.array.count == 0 || dragNode!.frame.width < target.array.last!.frame.width ){
                target.array.append( source.array.removeLast() )
                target.array.last!.run(SKAction.moveTo(y: discYAxisValues[target.array.count], duration: 0.01))
                //target.last?.run(SKAction.moveTo(y: -100 + (50*target.count), duration: 0.01))
                target.array.last!.run(SKAction.moveTo(x: theXcenter, duration: 0.01))
        }
        else if source === target {
            source.array.last!.run(SKAction.moveTo(y: discYAxisValues[source.array.count], duration: 0.01))
            //target.last?.run(SKAction.moveTo(y: -100 + (50*target.count), duration: 0.01))
            source.array.last!.run(SKAction.moveTo(x: sourceXcenter, duration: 0.01))
        }
        else {
            source.array.last!.run(SKAction.moveTo(y: discYAxisValues[source.array.count], duration: 0.01))
            //target.last?.run(SKAction.moveTo(y: -100 + (50*target.count), duration: 0.01))
            source.array.last!.run(SKAction.moveTo(x: sourceXcenter, duration: 0.01))
        }

        print("finished")
        self.dragNode = nil
        print(self.dragNode)
        
//        if source == tower1Array && target == tower2Array && ( tower2Array.count == 0 || dragNode.frame.height < tower2Array.last!.frame.height ){
//            if let sourced = tower1Array.last{
//                tower2Array.append(sourced)
//                tower1Array.removeLast()
//                tower2Array.last?.run(SKAction.moveTo(y: discYAxisValues[tower2Array.count], duration: 0.01))
//                tower2Array.last?.run(SKAction.moveTo(x: 0, duration: 0.01))
//            }
//        } else if source == tower1Array && target == tower3Array{
//            if let sourced = tower1Array.last{
//                tower3Array.append(sourced)
//                tower3Array.last?.run(SKAction.moveTo(y: discYAxisValues[tower3Array.count], duration: 0.01))
//                tower3Array.last?.run(SKAction.moveTo(x: 160, duration: 0.01))
//                tower1Array.removeLast()
//            }
//        } else if source == tower2Array && target == tower3Array{
//            if let sourced = tower2Array.last{
//                tower3Array.append(sourced)
//                tower3Array.last?.run(SKAction.moveTo(y: discYAxisValues[tower3Array.count], duration: 0.01))
//                tower3Array.last?.run(SKAction.moveTo(x: 160, duration: 0.01))
//                tower2Array.removeLast()
//            }
//        } else if source == tower2Array && target == tower1Array{
//            if let sourced = tower2Array.last{
//                tower1Array.append(sourced)
//                tower1Array.last?.run(SKAction.moveTo(y: discYAxisValues[tower1Array.count], duration: 0.01))
//                tower1Array.last?.run(SKAction.moveTo(x: -160, duration: 0.01))
//                tower2Array.removeLast()
//            }
//        } else if source == tower3Array && target == tower1Array{
//            if let sourced = tower3Array.last{
//                tower1Array.append(sourced)
//                tower1Array.last?.run(SKAction.moveTo(y: discYAxisValues[tower1Array.count], duration: 0.01))
//                tower1Array.last?.run(SKAction.moveTo(x: -160, duration: 0.01))
//                tower3Array.removeLast()
//            }
//        } else if source == tower3Array && target == tower2Array{
//            if let sourced = tower3Array.last{
//                tower2Array.append(sourced)
//                tower2Array.last?.run(SKAction.moveTo(y: discYAxisValues[tower2Array.count], duration: 0.01))
//                tower2Array.last?.run(SKAction.moveTo(x: 0, duration: 0.01))
//                tower3Array.removeLast()
//            }
//        } else{
//            print("There was an error in movement logic.")
//        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        dragNode = nil
    }
    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
