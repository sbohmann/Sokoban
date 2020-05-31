import Foundation
import UIKit

private func report(_ context: String, _ rect: CGRect) {
    NSLog("%@: %f, %f, %f, %f", context, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
}

class GameView : UIView {
    var x = 70
    var y = 100
    var dx = 1
    var dy = 1
    var shown = false;
    
    let sprite = UIImage(named: "player")!.cgImage!
    
    var game: OpaquePointer?
    var logic: OpaquePointer?
    
    func start() {
        Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true, block: { _ in
            self.move()
            self.setNeedsDisplay()
        })
        
        game = Game_create(self)
        logic = Logic_create(game)
        Logic_start(logic)
    }
    
    private func move() {
        if (x == 0 || CGFloat(x + sprite.width) >= bounds.width) {
            dx = -dx
        }
        if (y == 0 || CGFloat(y + sprite.height) >= bounds.height) {
            dy = -dy
        }
        x += dx
        y += dy
    }
    
    override func draw(_ rect: CGRect) {
//        report("draw: rect", rect)
//        report("draw: bounds", bounds)
        guard let g = UIGraphicsGetCurrentContext() else {
            return
        }
        g.setFillColor(CGColor(srgbRed: 0.7, green: 0.8, blue: 0.9, alpha: 1.0))
        g.fill(bounds)
        g.setLineWidth(20.0)
        g.addEllipse(in: rect)
        g.strokePath()
//        NSAttributedString(string: "Hi!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]).draw(at: CGPoint(x: x, y: y))
        
        if shown {
            let target = CGRect(x: x, y: y, width: sprite.width, height: sprite.height)
            g.draw(sprite, in: target)
        }
    }
    
    @objc func display() {
        shown = true;
    }
}
