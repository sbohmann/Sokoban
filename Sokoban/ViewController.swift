import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var gameView: GameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.start()
    }
}
