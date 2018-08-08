import SpriteKit
import UIKit

// The view controller for the game view.
class GameViewController: UIViewController {
    
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                (scene as! GameScene).viewController = self
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true

#if DEBUG
            view.showsFPS = true
            view.showsNodeCount = true
#endif
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return [.portrait, .portraitUpsideDown]
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "performSegue") {
            let vc = segue.destination as! ScoreViewController
            vc.score = score
        }
    }
    
    func gameEnded(score: Int) {
        self.score = score
        performSegue(withIdentifier: "performSegue", sender: nil)
    }

}
