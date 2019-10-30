//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyView: UIView{
    override func draw(_ rect: CGRect) {
        guard let cg = UIGraphicsGetCurrentContext()
            else {return}
        
        // Background
        let cgcolor = UIColor.blue.cgColor
        cg.setFillColor(cgcolor)
        cg.fill(rect)
        
        
        // Triangle roof
        cg.setStrokeColor(UIColor.brown.cgColor)
        cg.setLineWidth(10)
        cg.move(to: CGPoint(x: 50, y: 100))
        cg.addLine(to: CGPoint(x: 125, y: 25)) // tip of triangle
        cg.addLine(to: CGPoint(x: 200 , y: 100))
        cg.move(to: CGPoint(x: 125, y: 25)) // tip of triangle
        cg.addLine(to: CGPoint(x: 250, y: 25))
        cg.addLine(to: CGPoint(x: 325, y: 100))
        cg.addLine(to: CGPoint(x: 200, y: 100))
        cg.addLine(to: CGPoint(x: 200, y: 300))
        cg.addLine(to: CGPoint(x: 50, y: 300)) 
        cg.strokePath()
        
        // Frame
        cg.setStrokeColor(UIColor.brown.cgColor)
        cg.setLineWidth(10)
        cg.move(to: CGPoint(x: 50, y: 100))
        cg.addLine(to: CGPoint(x: 50, y: 300))
        cg.addLine(to: CGPoint(x: 200, y: 300))
        cg.addLine(to: CGPoint(x: 200, y: 100))
        cg.addLine(to: CGPoint(x: 50, y: 100))
        cg.strokePath()
        
        //door
//        cg.setStrokeColor(UIColor.brown.cgColor)
//        cg.setLineWidth(75)
//        cg.move(to: CGPoint(x: 125, y: 150))
//        cg.addLine(to: CGPoint(x: 125, y: 250))
//        cg.strokePath()
        
        
    }
}

class MyButton: UIButton{
    var myButtonState = "On"
    @objc func buttonWasPressed(){
        switch myButtonState{
        case "On": myButtonState = "Off"
        default: myButtonState = "On"
        }
        print(myButtonState)
        setNeedsDisplay() // tells the core grapics to redraw
    }
    override func draw(_ rect: CGRect){ // This block is for the top box
        switch myButtonState{
        case "Off":
            guard let cg = UIGraphicsGetCurrentContext()
                else {return}
            let cgColor2 = UIColor.blue.cgColor
            cg.setFillColor(cgColor2)
            cg.fill(rect)
            
            cg.setStrokeColor(UIColor.yellow.cgColor)
            cg.setLineWidth(20)
            cg.stroke(bounds.insetBy(dx: 20, dy: 20))
            
            cg.setStrokeColor(UIColor.black.cgColor)
            cg.setLineWidth(10)
            cg.move(to: CGPoint(x: 10, y: 10))
            cg.addLine(to: CGPoint(x: 240, y: 115))
            cg.strokePath()
        default:
            guard let cg = UIGraphicsGetCurrentContext()
                else {return}
            let cgColor = UIColor.red.cgColor
            cg.setFillColor(cgColor)
            cg.fill(rect)
            
            cg.setStrokeColor(UIColor.green.cgColor)
            cg.setLineWidth(20) // This sets the line width declared by the stroke
            cg.stroke(bounds.insetBy(dx: 20, dy: 20))
            print(rect)
            print(bounds) //This is the max distance that the heigth and width of the object can go.
            print(frame)
            
            cg.setStrokeColor(UIColor.purple.cgColor)
            cg.setLineWidth(10)
            //cg.move(to: CGPoint(x: 10, y: 10))
            //cg.Line(to: CGPoint(x: 240, y: 115))
            cg.move(to: CGPoint(x: 10, y: 10))
            cg.addLine(to: CGPoint(x: 240, y: 115))
            cg.strokePath()
        }
    }
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        let button = MyButton()
        button.frame = CGRect(x: 75, y:50, width: 250, height: 125)
        
        button.addTarget(button, action: #selector(button.buttonWasPressed), for: .touchUpInside)
        
        view.addSubview(button)
        
        let myView = MyView()
        myView.frame = CGRect(x: 15, y: 250, width: 350, height: 400)
        myView.backgroundColor = UIColor.yellow
        view.addSubview(myView)
        
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
