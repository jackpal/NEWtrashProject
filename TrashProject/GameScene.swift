import SpriteKit
import GameplayKit

class GameScene: SKScene,  SKPhysicsContactDelegate {
    var viewController: GameViewController?

  /// Collision categories:
  enum Category : UInt32 {
    /// Category for pieces of trash.
    case piece = 1
    /// Category for bucket bottom. Pieces that hit this are scored.
    case bucketBottom = 2
    /// Category for bucket side. Pieces that hit this bounce.
    case bucketSide = 4
    /// Category for the invisible boundary outside the screen.
    case boundary = 8
  }

    /// Sound that plays when a good choice is made.
    private let goodChoiceSound = SKAction.playSoundFileNamed("bing.wav", waitForCompletion: true)
    /// Sound that plays when a bad choice is made.
    private let badChoiceSound = SKAction.playSoundFileNamed("doh.wav", waitForCompletion: true)

    private var livesLabel : SKLabelNode!
    private var scoreLabel : SKLabelNode!
    private var statusLabel : SKLabelNode!

    private var lives : Int = 0 {
        didSet {
            livesLabel.text = "Lives: \(lives)"
        }
    }

    private var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    private var status: String = "" {
        didSet {
            statusLabel.text = "Status: \(status)"
        }
    }

    private var caughtTrash : SKNode?

    override func didMove(to view: SKView) {
        setupGameWorld()

        // Start dropping pieces.
        startDroppingPieces()
    }

    func setupGameWorld() {

        setupLabels()

        lives = 3
        score = 0

        /// A wall so any trash that leaves the screen is deleted.
        let boundaryWall = frame.insetBy(dx:-500, dy:-500)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom:boundaryWall)
        self.physicsBody?.categoryBitMask = Category.boundary.rawValue

        // Set self as the contact delegate. didBegin will be called when collisions occur.
        physicsWorld.contactDelegate = self

        // Slow down gravity
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.5)

        //Adds three buckets
        let bucketSize = CGSize(width: 235, height: 300)
        addBucket(bucketName: "trash", startingPosition: CGPoint(x: -355, y: -600), size: bucketSize)
        addBucket(bucketName: "recycling", startingPosition: CGPoint(x: -120, y: -600), size: bucketSize)
        addBucket(bucketName: "compost", startingPosition: CGPoint(x: 115, y: -600), size: bucketSize)
    }

    func startDroppingPieces() {
        let wait = SKAction.wait(forDuration: 1.7) //change drop speed here
        let block = SKAction.run({
            [unowned self] in
            self.addRandomPiece()
        })
        let sequence = SKAction.sequence([wait,block])

        run(SKAction.repeatForever(sequence), withKey: "pieceDropper")
    }

    func addRandomPiece() {
        // Pick a random piece
        let piece = allPieces[Int(arc4random_uniform(UInt32(allPieces.count)))]

        let margin : CGFloat = 50
        // Picks a random number between frame.minX and frame.maxX
        let x = CGFloat(arc4random_uniform(UInt32(frame.width-margin))) + frame.minX + margin / 2

        addPiece(imageName: piece.name,
                 pieceType: piece.type,
                      startingPosition: CGPoint(x:x, y: frame.maxY))

    }

    /// Adds a piece of trash/recycling/compost to scene.
    /// ImageName is the Asset picture name.
    func addPiece(imageName: String, pieceType: PieceType, startingPosition: CGPoint) {
        let piece = SKSpriteNode(imageNamed: imageName)
        piece.name = pieceType.rawValue
        piece.position = startingPosition
        piece.physicsBody = SKPhysicsBody(texture: piece.texture!,
                                          size: piece.texture!.size())
        piece.physicsBody?.categoryBitMask = Category.piece.rawValue
        piece.physicsBody?.contactTestBitMask =
            Category.piece.rawValue | Category.bucketBottom.rawValue | Category.boundary.rawValue
        addChild(piece)
      #if DEBUG
        print("Added \(piece)")
      #endif
    }


    /// Add bucket
    /// Bucket name should be "trash", "recycling", or "compost".
    func addBucket(bucketName: String, startingPosition: CGPoint, size: CGSize) {
        var splinePoints = [CGPoint(x: 0, y: size.height),
                            CGPoint(x: 0.20 * size.width, y: 0),
                            CGPoint(x: 0.80 * size.width, y: 0),
                            CGPoint(x: size.width, y: size.height)]
        let bucket = SKShapeNode(splinePoints: &splinePoints,
                                 count: splinePoints.count)
        bucket.name = bucketName
        bucket.position = startingPosition
        bucket.lineWidth = 5
        bucket.strokeColor = .white
        bucket.physicsBody = SKPhysicsBody(edgeChainFrom: bucket.path!)
        bucket.physicsBody?.restitution = 0.25
        bucket.physicsBody?.isDynamic = false
        bucket.physicsBody?.categoryBitMask = Category.bucketSide.rawValue
        addChild(bucket)

      // The bucket bottom is an invisible node that overlaps the bottom of the bucket.
      let bucketBottom = SKNode()
      bucketBottom.name = bucketName
      bucketBottom.position = CGPoint(x: startingPosition.x + size.width * 0.5,
                                      y: startingPosition.y - size.height * 0.6)
      bucketBottom.physicsBody = SKPhysicsBody(rectangleOf: size)
      bucketBottom.physicsBody?.isDynamic = false
      bucketBottom.physicsBody?.categoryBitMask = Category.bucketBottom.rawValue
      addChild(bucketBottom)
    }

    func setupLabels() {
        livesLabel = SKLabelNode(fontNamed: "Chalkduster")
        livesLabel.fontSize = 55
        livesLabel.fontColor = .white
        livesLabel.position = CGPoint(x: frame.minX + 550, y: frame.maxY - 50)

        addChild(livesLabel)

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.fontSize = 55
        scoreLabel.fontColor = .black
        scoreLabel.position = CGPoint(x: frame.maxX - 550, y: frame.maxY - 50)

        addChild(scoreLabel)

        statusLabel = SKLabelNode(fontNamed: "Chalkduster")
        statusLabel.fontSize = 50
        statusLabel.fontColor = .white
        statusLabel.position = CGPoint(x: frame.minX + 420 , y: frame.maxY - 100)

        addChild(statusLabel)
    }

    /// called when drag begins
    func touchBegin(atPoint pos : CGPoint) {
        let node = atPoint(pos)
        if node.physicsBody?.categoryBitMask == Category.piece.rawValue {
            caughtTrash = node
        }
    }

    /// called when finger moves during drag
    func touchMoved(toPoint pos : CGPoint) {
        if let haveCaughtTrash = caughtTrash {
            haveCaughtTrash.position = pos
        }
    }

    /// called when drag ends
    func touchEnd(atPoint pos : CGPoint) {
        caughtTrash = nil
    }

    /// called by system when drag begins
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchBegin(atPoint:touch.location(in: self))
        }
    }

    /// called by system when drag moves
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchMoved(toPoint:touch.location(in: self))
        }
    }

    /// called by system when drag ends
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchEnd(atPoint:touch.location(in: self))
        }
    }

    /// called by system when drag is cancelled like when a phone call is recived
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchEnd(atPoint:touch.location(in: self))
        }
    }

    /// collision handler
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        // Check for a body having already been removed
        if firstBody.node?.physicsBody == nil {
            return
        }
        //if a piece hits a bucket, it will disapear.
        if firstBody.categoryBitMask == Category.piece.rawValue {
            switch (secondBody.categoryBitMask) {
            case Category.bucketBottom.rawValue:
                let pieceName = firstBody.node!.name!
                let bucketName = secondBody.node!.name!
                #if DEBUG
                print("\(pieceName) hit \(bucketName)")
                #endif
                if pieceName == bucketName {
                    score += 1 //adding one point
                    status = "Correct"
                    statusLabel.fontColor = .green
                    removeBody(body: firstBody)
                    run(goodChoiceSound)
                } else {
                    removeBody(body: firstBody)
                    if lives > 0 {
                        lives -= 1 //subtracting one point
                        status = "Incorrect"
                        statusLabel.fontColor = .red
                        if lives == 0 {
                            run(badChoiceSound) {
                                self.view?.isPaused = true
                                self.viewController!.gameEnded(score:self.score)
                            }
                        } else {
                            run(badChoiceSound)
                        }
                    }
                }
            case Category.boundary.rawValue:
                // Object has fallen off the the edge of the screen.
                removeBody(body: firstBody)
            default:
                break
            }
        }
    }

    func removeBody(body: SKPhysicsBody) {
        if let node = body.node {
            node.removeFromParent()
            node.physicsBody = nil
        }
    }

}
