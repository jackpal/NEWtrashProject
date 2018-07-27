//
//  GameScene.swift
//  TrashProject
//
//  Created by Sydrah Al-saegh on 7/23/18.
//  Copyright © 2018 Sydrah Al-saegh. All rights reserved.
//

import SpriteKit
import GameplayKit

// The type of a piece.
enum PieceType: String {
    case compost = "compost"
    case recycling = "recycling"
    case trash = "trash"
}

// An individual piece of trash
struct Piece {
    let name: String
    let type: PieceType
}

class GameScene: SKScene,  SKPhysicsContactDelegate {
    var viewController: GameViewController?
    
    // Define collision cetegories
    private let pieceCategory    : UInt32 = 0x1 << 0
    private let bucketCategory   : UInt32 = 0x1 << 1
    private let boundaryCategory : UInt32 = 0x1 << 2
    
    private var label : SKLabelNode?
    
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
    
    var i : Int = 0
    
    //var numCorrect: Int = 0
   // var numIncorrect: Int = 0

    
    /*
    var highScoreLabel = SKLabelNode()
    var highScore = UserDefaults().integer(forKey: "HIGHSCORE")
    */
   
    private let allPieces = [
        Piece(name: "diapers", type:.trash),
        Piece(name: "straw", type:.trash),
        Piece(name: "candyWrapper", type:.trash),//Teacher suggests type should be string
        Piece(name: "paperCup", type:.trash),
        Piece(name: "oldBulb", type:.trash),
        Piece(name: "shotNeedle", type:.trash),
        
        
        // Recycling
        Piece(name: "bake", type:.recycling),
        Piece(name: "battery", type:.recycling),
        Piece(name: "can", type:.recycling),
        Piece(name: "car", type:.recycling),
        Piece(name: "cardboardBox", type:.recycling),
        Piece(name: "carpet", type:.recycling),
        Piece(name: "cerealBox", type:.recycling),
        Piece(name: "drink", type:.recycling),
        Piece(name: "envelopes", type:.recycling),
        Piece(name: "etrash", type:.recycling),
        Piece(name: "fluolight", type:.recycling),
        Piece(name: "foil", type:.recycling),
        Piece(name: "fridge", type:.recycling),
        Piece(name: "mattress", type:.recycling),
        Piece(name: "paintcans", type:.recycling),
        Piece(name: "paper", type:.recycling),
        Piece(name: "paperBag", type:.recycling),
        Piece(name: "milkCarton", type:.recycling),
        Piece(name: "yogogo", type:.recycling),
        Piece(name: "battery", type:.recycling),
        Piece(name: "soda", type:.recycling),
        Piece(name: "foil", type:.recycling),
        Piece(name: "shampoo", type:.recycling),
        
        // Compost
        Piece(name: "appleCore", type:.compost),
        Piece(name: "avocadoPits", type:.compost),
        Piece(name: "eggCarton", type:.compost),
        Piece(name: "eggShells", type:.compost),
        Piece(name: "foodWaste", type:.compost),
        Piece(name: "leaf", type:.compost),
        Piece(name: "muffinWraper", type:.compost),
        Piece(name: "peanuts", type:.compost),
        Piece(name: "toothpick", type:.compost),
        Piece(name: "pizzaBox", type:.compost),    ]
    
    var highScore: Int{
        get {
            return UserDefaults.standard.integer(forKey: "highScore")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "highScore")
        }
    }

   
    override func didMove(to view: SKView) {
        setupGameWorld()

        // Start dropping pieces.
        startDroppingPieces()
    }
    
    func setupGameWorld() {
        
        setupLabels()
        
        lives = 3
        score = 0
        highScore = 0
       
        
        // A wall to the garbage doesnt go past the trash cans.
        let boundaryWall = frame.insetBy(dx:-500, dy:-500)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom:boundaryWall)
        self.physicsBody?.categoryBitMask = boundaryCategory
        
        // Set self as the contact delegate. didBegin will be called when collisions occur.
        physicsWorld.contactDelegate = self
        
        // Slow down gravity
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.5)
        
        
        //Adds three buckets
        addBucket(bucketName: "trash", startingPosition: CGPoint(x: -355, y: -600), size: CGPoint(x: 235, y: 300))
        addBucket(bucketName: "recycling", startingPosition: CGPoint(x: -120, y: -600), size: CGPoint(x: 235, y: 300))
        addBucket(bucketName: "compost", startingPosition: CGPoint(x: 115, y: -600), size: CGPoint(x: 235, y: 300))
    }
    
    func startDroppingPieces() {
        let wait = SKAction.wait(forDuration: 3) //change drop speed here
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
        
        // Picks a random number between frame.minX and frame.maxX
        let x = CGFloat(arc4random_uniform(UInt32(frame.width))) + frame.minX
        
        addPiece(imageName: piece.name,
                 nodeName: piece.type,
                      startingPosition: CGPoint(x:x, y: frame.maxY))

    }
    

        //add more types of trash, also add recycling and compost image names, corrosponds to assets/pics
    


    //Adds a piece of trash/recycling/compost to scene. Image name is the Asset picture name.
    // Node name should be "trash" or "recycling" or "compost"
    
    func addPiece(imageName: String, nodeName: PieceType, startingPosition: CGPoint) {
        let piece = SKSpriteNode(imageNamed: imageName)
        piece.name = nodeName.rawValue
        piece.position = startingPosition
        piece.physicsBody = SKPhysicsBody(texture: piece.texture!,
                                          size: piece.texture!.size())
        piece.physicsBody?.categoryBitMask = pieceCategory
        piece.physicsBody?.contactTestBitMask = pieceCategory | bucketCategory | boundaryCategory
        addChild(piece)
        
        print("Added \(piece)")
    }
    
    
    //Bucket name should be "recyclingBucket" "trashBucket" "compostBucket"
    //Add bucket
    func addBucket(bucketName: String, startingPosition: CGPoint, size: CGPoint) {
        var splinePoints = [CGPoint(x: 0, y: size.y),
                            CGPoint(x: 0.20 * size.x, y: 0),
                            CGPoint(x: 0.80 * size.x, y: 0),
                            CGPoint(x: size.x, y: size.y)]
        let bucket = SKShapeNode(splinePoints: &splinePoints,
                                 count: splinePoints.count)
        bucket.name = bucketName
        bucket.position = startingPosition
        bucket.lineWidth = 5
        bucket.strokeColor = .white
        bucket.physicsBody = SKPhysicsBody(edgeChainFrom: bucket.path!)
        bucket.physicsBody?.restitution = 0.25
        bucket.physicsBody?.isDynamic = false
        bucket.physicsBody?.categoryBitMask = bucketCategory
        addChild(bucket)
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

    // called when drag begins
    func touchBegin(atPoint pos : CGPoint) {
        let node = atPoint(pos)
        if node.physicsBody?.categoryBitMask == pieceCategory {
            caughtTrash = node
        }
    }
    
    // called when finger moves during drag
    func touchMoved(toPoint pos : CGPoint) {
        if let haveCaughtTrash = caughtTrash {
            haveCaughtTrash.position = pos
        }
    }
    
    // called when drag ends
    func touchEnd(atPoint pos : CGPoint) {
        caughtTrash = nil
    }
        
    // called by system when drag begins
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchBegin(atPoint:touch.location(in: self))
        }
    }
    
    // called by system when drag moves
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchMoved(toPoint:touch.location(in: self))
        }
    }
    
    // called by system when drag ends
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchEnd(atPoint:touch.location(in: self))
        }
    }
    
    // called by system when drag is cancelled like when a phone call is recived
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchEnd(atPoint:touch.location(in: self))
        }
    }

    // collision handler
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
        if firstBody.categoryBitMask == pieceCategory {
            switch (secondBody.categoryBitMask) {
            case bucketCategory:
                let pieceName = firstBody.node!.name!
                let bucketName = secondBody.node!.name!
                
                if pieceName == bucketName {
                    score += 1 //adding one point
                    status = "Correct"
                    statusLabel.fontColor = .green
                    print("score", firstBody, score)
                    removeBody(body: firstBody)
                } else {
                    lives -= 1 //subtracting one point
                    status = "Incorrect"
                    statusLabel.fontColor = .red
                    print("lives", firstBody, lives)
                    removeBody(body: firstBody)
                    if lives == 0 {
                        self.view?.isPaused = true
                        viewController!.gameEnded(score:score)
                    }
                }
            case boundaryCategory:
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
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    

}



