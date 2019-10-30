//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}

// static vs non static
class Ex {
    static var a = 0
    var b = 0
    init(){
        Ex.a += 1
        b = Ex.a
    }
}

func demo (){
    var a : [Ex] = []
    for _ in 0 ... 100 {
        let e = Ex()
        a.append(e)
        print(Ex.a, e.b)//1 1| 2,2 \... 100| 100
    }
    for e in a {
        print(Ex.a, e.b) //100 1 | 100 2 | 100 3 | 100 4
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
