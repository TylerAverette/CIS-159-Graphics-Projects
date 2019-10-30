//
//  ViewController.swift
//  TOH
//
//  Created by Student User on 9/23/19.
//  Copyright © 2019 Student User. All rights reserved.
//

import UIKit

class Disc: UIButton{
    var currentTower = 1
}

class ViewController: UIViewController {
    @IBOutlet weak var infoLabel: UILabel!
    
    var tower1Array: [UIButton] = []
    var tower2Array: [UIButton] = []
    var tower3Array: [UIButton] = []
    
    var tower1CenterX :CGFloat = 150 // sender.center
    var tower2CenterX :CGFloat {return tower1CenterX+150} //  = CGPoint(x:center.x+xOffSet, y:center.y)
    var tower3CenterX :CGFloat {return tower1CenterX+300} //  = CGPoint(x:center.x+xOffSet*2, y:center.y)
    let xOffSet:CGFloat = 150
    
    @IBOutlet weak var towerStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = "Status: Game in progress"
        
        //Draw Discs
        let colors : [UIColor] = [.red,.blue,.purple,.cyan,.magenta, .gray]
        let numDisc = 5
        let discHeight = Int(towerStackView.frame.height) / numDisc
        var discWidth = Int(view.frame.width) / numDisc
        var discXAxis = Int(view.frame.width) / Int(towerStackView.frame.width)
        var discYAxis = Int(towerStackView.frame.minY)+25 * numDisc
        tower1CenterX = CGFloat(discXAxis + discWidth/2)
        
        for i in 0...numDisc{
            let button = Disc()
            button.frame = CGRect(x: discXAxis, y: discYAxis, width: discWidth, height: discHeight)
            button.backgroundColor = colors[i]
            button.currentTower = 1
            tower1Array.append(button)
            discYAxis -= Int(button.frame.height)
            discWidth -= 10
            discXAxis += 5
            button.addTarget(self, action: buttoncode, for: .touchUpInside)
            
            towerStackView.addSubview(button)
            
            
            if tower3Array.count == numDisc{
                infoLabel.text = "Status: Winner!"
            }

        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    let buttoncode = #selector(button)
   
    
    @objc func button(_ sender : Disc){

        
        var yAxisValues: [Int] = []
        let towerBaseY = 368
        let numDiscs: Int = tower1Array.count + tower2Array.count + tower3Array.count
        let discHeight = Int(sender.frame.height)
        var numMoves = 0
        
        for index in 0...numDiscs-1{
//            yAxisValues[index] = towerBaseY - discHeight
            yAxisValues.insert(towerBaseY-discHeight*index+1, at: index)
        }


        func moving(_ t1 : inout [UIButton], _ t2: inout [UIButton], _ t : Int){
            //sender.center.x = self.tower2CenterX
            t1.removeLast()
            sender.center.y = CGFloat(yAxisValues[t2.count])
            t2.append(sender)
            sender.currentTower = t
        }
        
        func moved(_ t1 : inout [UIButton], _ t2: inout [UIButton], _ t : Int)->Bool{
            if t2.count == 0 || sender.frame.width < t2.last!.frame.width{
                moving(&t1, &t2, t)
                return true
                
            }
            else { return false }
        }

        if sender.center.x == tower1CenterX{
            guard sender == tower1Array.last else {return}
            // If it comes from tower 1, check tower 1 -> tower2
            
            if moved(&tower1Array, &tower2Array, 2) {
                sender.center.x = tower2CenterX
            }
            else if moved(&tower1Array, &tower3Array, 3) {
                sender.center.x = tower3CenterX
            }
        }
        else if sender.center.x == tower2CenterX{
            guard sender == tower2Array.last else {return}
            // If it comes from tower 1, check tower 1 -> tower2
            
            if moved(&tower2Array, &tower3Array, 3) {
                sender.center.x = tower3CenterX
            }
            else if moved(&tower2Array, &tower1Array, 1) {
                sender.center.x = tower1CenterX
            }
        }
        else {
            guard sender == tower3Array.last else {return}
            // If it comes from tower 1, check tower 1 -> tower2
            
            if moved(&tower3Array, &tower1Array, 1) {
                sender.center.x = tower1CenterX
            }
            else if moved(&tower3Array, &tower2Array, 2) {
                sender.center.x = tower2CenterX
            }
        }

//         if sender.center.x == tower1CenterX{
//            guard sender == tower1Array.last else {return}
//            // If it comes from tower 1, check tower 1 -> tower2
//
//            if tower2Array.count == 0 || sender.frame.width < tower2Array.last!.frame.width{
//                moving(&tower1Array, &tower2Array,2)
//                sender.center.x = tower2CenterX
////                tower1Array.removeLast()
////                sender.center.y = CGFloat(yAxisValues[tower2Array.count])
////                tower2Array.append(sender)
////                sender.currentTower = 2
////                numMoves += 1
////                infoLabel.text = "Number of moves: \(numMoves)"
//            } else if tower3Array.count == 0 || sender.frame.width < tower3Array.last!.frame.width{ // check tower 1 -> 3
//                 moving(&tower1Array, &tower3Array,2)
//                sender.center.x = tower3CenterX
////                tower1Array.removeLast()
////                sender.center.y = CGFloat(yAxisValues[tower3Array.count])
////                tower3Array.append(sender)
////                sender.currentTower = 2
////                numMoves += 1
////                infoLabel.text = "Number of moves: \(numMoves)"
//            } else {return}
//         }
//         else if sender.center.x == tower2CenterX{
//            guard sender == tower2Array.last else {return}
//            if tower3Array.count == 0 || sender.frame.width < tower3Array.last!.frame.width{ //Check 2 -> 3
//                 moving(&tower2Array, &tower3Array,3)
//               sender.center.x = tower3CenterX
////                tower2Array.removeLast()
////                sender.center.y = CGFloat(yAxisValues[tower3Array.count])
////                tower3Array.append(sender)
////                sender.currentTower = 3
////                numMoves += 1
////                infoLabel.text = "Number of moves: \(numMoves)"
//            } else if tower1Array.count == 0 || sender.frame.width < tower1Array.last!.frame.width{ // check tower 2 -> 1
//                moving(&tower2Array, &tower1Array,2)
//               sender.center.x = tower1CenterX
////                tower2Array.removeLast()
////                sender.center.y = CGFloat(yAxisValues[tower1Array.count])
////                tower1Array.append(sender)
////                sender.currentTower = 2
////                numMoves += 1
////                infoLabel.text = "Number of moves: \(numMoves)"
//            } else {return}
//         }
//        else{
//            guard sender == tower3Array.last else {return}
//            if tower1Array.count == 0 || sender.frame.width < tower1Array.last!.frame.width{ //Check 3 -> 1
//                moving(&tower3Array, &tower1Array,1)
//                sender.center.x = tower1CenterX
////                tower3Array.removeLast()
////                sender.center.y = CGFloat(yAxisValues[tower1Array.count])
////                tower1Array.append(sender)
////                sender.currentTower = 1
////                numMoves += 1
////                infoLabel.text = "Number of moves: \(numMoves)"
//            } else if tower2Array.count == 0 || sender.frame.width < tower2Array.last!.frame.width{ // check tower 3 -> 2
//                moving(&tower3Array, &tower2Array,2)
//                sender.center.x = tower2CenterX
////                tower3Array.removeLast()
////                sender.center.y = CGFloat(yAxisValues[tower2Array.count])
////                tower2Array.append(sender)
////                sender.currentTower = 2
////                numMoves += 1
////                infoLabel.text = "Number of moves: \(numMoves)"
//            }else{return}
//                return
//        }
        
    }
}
