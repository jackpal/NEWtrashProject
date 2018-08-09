import UIKit

/// UserDefaults key used to store the high score.
let highScoreKey = "highScore"

/// View controller for Score page.
class ScoreViewController: PortraitOnlyViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!

    var highScore: Int = UserDefaults.standard.integer(forKey: highScoreKey) {
        didSet {
            if oldValue != highScore {
                UserDefaults.standard.set(highScore, forKey: highScoreKey)
                highScoreLabel.text = "High Score: \(highScore)"
            }
        }
    }
  
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "Score: \(score)"
        
        highScore = max(highScore, score)
        highScoreLabel.text = "High Score: \(highScore)"
    }

}
