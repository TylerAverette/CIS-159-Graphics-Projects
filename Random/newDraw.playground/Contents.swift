import UIKit
import PlaygroundSupport

class DrawSomething: UIView{
    public override func draw(_ rect: CGRect){
        guard let cg = UIGraphicsGetCurrentContext() else{return}
        let backgroundColor = UIColor.orange.cgColor
        cg.setFillColor(backgroundColor)
        cg.fill(rect)
        
        cg.setStrokeColor(UIColor.yellow.cgColor)
        cg.setLineWidth(20)
        
        cg.move(to: CGPoint(x: 10, y: 10)) // start point of line
//        cg.stroke(bounds.insetBy(dx: 20, dy: 20)) // move item deeper in frame
        cg.addLine(to: CGPoint(x: 240, y: 115)) // end point of line
        cg.strokePath() // draw the line
    }

}

class CreateButton: UIButton{
    public override func draw(_ rect: CGRect){
        guard let cg = UIGraphicsGetCurrentContext() else {return}
        let backgroundColor = UIColor.green.cgColor
        cg.setFillColor(backgroundColor)
        cg.fill(rect)
        
        cg.setStrokeColor(UIColor.yellow.cgColor)
        cg.setLineWidth(20)
        
        cg.move(to: CGPoint(x: 10, y: 10))
        cg.addLine(to: CGPoint(x: 240, y: 115))
        cg.strokePath()
    }
}

class CreateLabel: UILabel{
    public override func draw(_ rect: CGRect){

        // This block draws a line on the label
        guard let cg = UIGraphicsGetCurrentContext() else {return}
        
        let backgroundColor = UIColor.gray.cgColor
        cg.setFillColor(backgroundColor) // color of label
        cg.fill(rect) // which label to fill

        cg.setStrokeColor(UIColor.yellow.cgColor) // color of line
        cg.setLineWidth(20)

        cg.move(to: CGPoint(x: 10, y: 10)) // go to start of line
        cg.addLine(to: CGPoint(x: 240, y: 115)) // set end point of line
        cg.strokePath() // draw the line
        
        super.draw(rect)
    }
}

class CreateChangeButton: UIButton{
    var myButtonState = "On"
    @objc func buttonWasPressed(){
        switch myButtonState{
        case "On":
            myButtonState = "Off"
        default:
            myButtonState = "On"
        }
        setNeedsDisplay()
    }
    public override func draw(_ rect: CGRect) {
        switch myButtonState {
        case "Off":
            //This block draws a circle inside of the label
            var path = UIBezierPath()
            path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 100, height: 100))
            UIColor.black.setStroke()
            UIColor.red.setFill()
            path.lineWidth = 5
            path.stroke()
            path.fill()
        default:
            guard let cg = UIGraphicsGetCurrentContext() else {return}
            cg.setFillColor(UIColor.blue.cgColor)
            cg.fill(rect)
            
            cg.setStrokeColor(UIColor.yellow.cgColor)
            cg.setLineWidth(20)
            
            cg.move(to: CGPoint(x: 10, y: 10))
            cg.addLine(to: CGPoint(x: 240, y: 115))
            cg.strokePath()
        }
        
    }
}

class MyViewController: UIViewController{
    
//    func alter(_ v : UIView ){
//        v.context
//    }
    
    override func loadView() {
        // setup background
        let view = DrawSomething() //UIView()
        view.backgroundColor = .white
        
        // Draw a view then draw inside of that view
        let myView = DrawSomething()
        myView.frame = CGRect(x: 15,  y: 150, width: 100, height: 100)
        view.addSubview(myView)
        
        // Draw a button then draw inside of that button
        let myButton = CreateButton();
        myButton.frame = CGRect(x: 15, y: 250, width: 100, height: 100)
        myButton.setTitle("Button", for: .normal)
        view.addSubview(myButton)
        
        // Draw a label then draw inside that label
        let myLabel = CreateLabel();
        myLabel.frame = CGRect(x: 15, y:350, width: 100, height: 100)
        myLabel.text = "Label"
        view.addSubview(myLabel)
        
        // Draw a button that can change
        let myChangeButton = CreateChangeButton()
        myChangeButton.frame = CGRect(x: 15, y: 450, width: 100, height: 100)
        myChangeButton.addTarget(myChangeButton, action: #selector(myChangeButton.buttonWasPressed), for: .touchUpInside)
        myChangeButton.setTitle("Change", for: .normal)
        view.addSubview(myChangeButton)
        
        self.view = view
    }
}
PlaygroundPage.current.liveView = MyViewController()
