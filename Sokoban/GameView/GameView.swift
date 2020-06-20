import Foundation
import UIKit

private func report(_ context: String, _ rect: CGRect) {
    NSLog("%@: %f, %f, %f, %f", context, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
}

class GameView : UIView, UIGestureRecognizerDelegate {
    var sprites = Dictionary<UInt, UIImage>()
    
    var game: OpaquePointer?
    var logic: OpaquePointer?
    
    func start() {
        setupSwipeRecognizers()
        game = Game_create(self)
        logic = Logic_create(game)
        Logic_start(logic)
    }
    
    func setupSwipeRecognizers() {
        setupSwipeRecognizer(UISwipeGestureRecognizer.Direction.up)
        setupSwipeRecognizer(UISwipeGestureRecognizer.Direction.down)
        setupSwipeRecognizer(UISwipeGestureRecognizer.Direction.left)
        setupSwipeRecognizer(UISwipeGestureRecognizer.Direction.right)
    }
    
    func setupSwipeRecognizer(_ direction: UISwipeGestureRecognizer.Direction) {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeReceived))
        recognizer.direction = direction
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func swipeReceived(gesture: UISwipeGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.ended {
            switch gesture.direction {
                case .up: key(1)
                case .down: key(2)
                case .left: key(3)
                case .right: key(4)
                default: break
            }
        }
    }
    
    // TODO find out why Int is required for a size_t argument (should be size_t)
    func key(_ value: Int) {
        Logic_handle_key(logic, value)
    }
    
//    @IBAction func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer) {
//        if gestureRecognizer.state == .ended {
//            // Perform action.
//        }
//    }
    
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
        
        Logic_draw(logic)
    }
    
    @objc func loadSprite(key: UInt, name: String) {
        NSLog("loadSprite - key: \(key), path: \(name)")
        let image = UIImage(named: name)
        sprites[key] = image
    }
    
    @objc func drawSprite(key: UInt, position: Position) {
        guard let g = UIGraphicsGetCurrentContext() else {
            return
        }
        let sprite = sprites[key]!.cgImage!
        let target = CGRect(x: position.x, y: position.y, width: sprite.width, height: sprite.height)
        g.draw(sprite, in: target)
    }
    
    @objc func redraw() {
        setNeedsDisplay()
    }
}
