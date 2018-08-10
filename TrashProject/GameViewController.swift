import SpriteKit
import UIKit

// The view controller for the game view.
class GameViewController: PortraitOnlyViewController {
    
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                (scene as! GameScene).viewController = self
                // Set the scale mode to scale to fit the window.
                scene.scaleMode = .aspectFit

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

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    // Widen view if needed, to avoid pillboxing on wider devices like iPads.
    let skView = self.view as! SKView
    if let scene = skView.scene {
      var size = scene.size
      let newWidth = view.bounds.size.width / view.bounds.height * size.height
      if newWidth > size.width {
        size.width = newWidth
        scene.size = size
      }
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
