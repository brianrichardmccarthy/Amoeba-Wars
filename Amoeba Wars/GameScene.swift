//
//  GameScene.swift
//  Amoeba Wars
//
//  Created by 20063914 on 23/11/2018.
//  Copyright © 2018 Brian McCarthy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let margin = CGFloat(100)
    var histolyticaButton: ButtonNode!
    var fowleriButton: ButtonNode!
    var proteusButton: ButtonNode!
    let coinLeftLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let coinRightLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let healthLeftLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let healthRightLabel = SKLabelNode(fontNamed: "Courier-Bold")
    var lastUpdateTimeInterval: TimeInterval = 0
    var gameOver = false
    var computer: AIPlayer?
    var baseLeft: Base!
    var baseRight: Base!
    
    var entityManager: EntityManager!
    
    override func didMove(to view: SKView) {
        
        // Create entity manager
        entityManager = EntityManager(scene: self)
        computer = AIPlayer(entityManager: entityManager)
        
        // Start background music
        let bgMusic = SKAudioNode(fileNamed: SoundFile.BackgroundMusic)
        bgMusic.autoplayLooped = true
        addChild(bgMusic)
        
        // Add background
        let background = SKSpriteNode(imageNamed: ImageName.Background)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = Layer.Background
        background.size = self.size
        addChild(background)
        
        // Add histolytica button
        histolyticaButton = ButtonNode(iconName: ImageName.HistolyticaLeft, text: String(GameConfig.HistolyticaCost), onButtonPress: histolyticaPressed)
        histolyticaButton.position = CGPoint(x: size.width * 0.25, y: margin + histolyticaButton.size.height / 2)
        addChild(histolyticaButton)
        
        // Add fowleri button
        fowleriButton = ButtonNode(iconName: ImageName.FowleriLeft, text: String(GameConfig.FowleriCost), onButtonPress: fowleriPressed)
        fowleriButton.position = CGPoint(x: size.width * 0.5, y: margin + fowleriButton.size.height / 2)
        addChild(fowleriButton)
        
        // Add proteus button
        proteusButton = ButtonNode(iconName: ImageName.ProteusLeft, text: String(GameConfig.ProteusCost), onButtonPress: proteusPressed)
        proteusButton.position = CGPoint(x: size.width * 0.75, y: margin + proteusButton.size.height / 2)
        addChild(proteusButton)
        
        // Add coin left indicator
        let coinLeft = SKSpriteNode(imageNamed: ImageName.Coin)
        
        coinLeft.position = CGPoint(x: margin + coinLeft.size.width/2,
                                    y: size.height - margin - coinLeft.size.height/2)
        addChild(coinLeft)
        coinLeftLabel.fontSize = 50
        coinLeftLabel.fontColor = SKColor.black
        coinLeftLabel.position = CGPoint(x: coinLeft.position.x + coinLeft.size.width/2 + margin, y: coinLeft.position.y)
        coinLeftLabel.zPosition = Layer.HUD
        coinLeftLabel.horizontalAlignmentMode = .left
        coinLeftLabel.verticalAlignmentMode = .center
        coinLeftLabel.text = "0"
        addChild(coinLeftLabel)
        
        // Add coin right indicator
        let coinRight = SKSpriteNode(imageNamed: ImageName.Coin)
        
        coinRight.position = CGPoint(x: self.size.width - (margin + coinRight.size.width/2),
                                    y: size.height - margin - coinRight.size.height/2)
        addChild(coinRight)
        coinRightLabel.fontSize = 50
        coinRightLabel.fontColor = SKColor.black
        coinRightLabel.position = CGPoint(x: coinRight.position.x - coinRight.size.width/2 - margin, y: coinRight.position.y)
        coinRightLabel.zPosition = Layer.HUD
        coinRightLabel.horizontalAlignmentMode = .right
        coinRightLabel.verticalAlignmentMode = .center
        coinRightLabel.text = "0"
        addChild(coinRightLabel)
        
        // Add base left
        baseLeft = Base(imageName: ImageName.Base_Left_Attack, team: .teamLeft, entityManager: entityManager)
        if let spriteComponent = baseLeft.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.size.width/2, y: size.height/2)
        }
        entityManager.add(baseLeft)
        
        healthLeftLabel.fontSize = 50
        healthLeftLabel.fontColor = SKColor.black
        healthLeftLabel.position = CGPoint(x: coinLeftLabel.position.x + margin, y: coinLeft.position.y - coinLeftLabel.fontSize * 1.5)
        healthLeftLabel.zPosition = Layer.HUD
        healthLeftLabel.horizontalAlignmentMode = .right
        healthLeftLabel.verticalAlignmentMode = .center
        healthLeftLabel.text = "Health \(baseLeft.component(ofType: HealthComponent.self)!.health)"
        addChild(healthLeftLabel)
        
        // Add base right
        baseRight = Base(imageName: ImageName.Base_Right_Attack, team: .teamRight, entityManager: entityManager)
        if let spriteComponent = baseRight.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: size.width - spriteComponent.node.size.width/2, y: size.height/2)
        }
        entityManager.add(baseRight)
        
        healthRightLabel.fontSize = 50
        healthRightLabel.fontColor = SKColor.black
        healthRightLabel.position = CGPoint(x: coinRight.position.x - coinRight.size.width/2 - margin, y: coinLeft.position.y - coinLeftLabel.fontSize * 1.5)
        healthRightLabel.zPosition = Layer.HUD
        healthRightLabel.horizontalAlignmentMode = .left
        healthRightLabel.verticalAlignmentMode = .center
        healthRightLabel.text = "Health \(baseLeft.component(ofType: HealthComponent.self)!.health)"
        addChild(healthRightLabel)
        
        let heartRight = SKSpriteNode(imageNamed: ImageName.Heart)
        heartRight.position = CGPoint(x: self.size.width - (margin + coinRight.size.width * 4), y: size.height - margin - coinRight.size.height * 2)
        heartRight.size = CGSize(width: 75, height: 75)
        addChild(heartRight)
        
        let heartLeft = SKSpriteNode(imageNamed: ImageName.Heart)
        heartLeft.position = CGPoint(x: margin + coinLeft.size.width/2,
                                     y: size.height - margin - coinLeft.size.height * 2)
        heartLeft.size = CGSize(width: 75, height: 75)
        addChild(heartLeft)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        print("\(touchLocation)")
        
        if gameOver {
            let newScene = GameScene(size: size)
            newScene.scaleMode = scaleMode
            view?.presentScene(newScene, transition: SKTransition.flipHorizontal(withDuration: 0.5))
            return
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if (gameOver) {
            return
        }
        
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        entityManager.update(deltaTime)
        
        // update player left coins
        if let playerLeft = entityManager.base(for: .teamLeft),
            let playerLeftBase = playerLeft.component(ofType: BaseComponent.self) {
            coinLeftLabel.text = "\(playerLeftBase.coins)"
        }
        
        // update player right coins
        if let playerRight = entityManager.base(for: .teamRight),
            let playerRightBase = playerRight.component(ofType: BaseComponent.self) {
            coinRightLabel.text = "\(playerRightBase.coins)"
            computer!.update(score: playerRightBase.coins)
        }
        
        let left = baseLeft.component(ofType: HealthComponent.self)!
        let right = baseLeft.component(ofType: HealthComponent.self)!
        healthLeftLabel.text = "\(left.health)"
        healthRightLabel.text = "\(right.health)"
        
        if (left.isDead() || right.isDead()) {
            gameOver = true
            children.forEach {
                $0.removeFromParent()
            }
            let playAgain = SKLabelNode(fontNamed: "Courier-Bold")
            playAgain.fontSize = 50
            playAgain.fontColor = SKColor.black
            playAgain.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            playAgain.zPosition = Layer.HUD
            playAgain.horizontalAlignmentMode = .left
            playAgain.verticalAlignmentMode = .center
            playAgain.text = "Tap anywhere to play again"
            addChild(playAgain)
        }
        
    }
    
    //MARK: - Button methods
    func histolyticaPressed() {
        entityManager.spawnAmoeba(team: .teamLeft, amoebaType: .Histolytica)
    }
    
    func proteusPressed() {
        entityManager.spawnAmoeba(team: .teamLeft, amoebaType: .Proteus)
    }
    
    func fowleriPressed() {
        entityManager.spawnAmoeba(team: .teamLeft, amoebaType: .Fowleri)
    }
    
}
