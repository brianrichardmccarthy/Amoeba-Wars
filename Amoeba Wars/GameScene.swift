//
//  GameScene.swift
//  Amoeba Wars
//
//  Created by 20063914 on 23/11/2018.
//  Copyright © 2018 Brian McCarthy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let margin = CGFloat(30)
    var histolyticaButton: ButtonNode!
    var fowleriButton: ButtonNode!
    var proteusButton: ButtonNode!
    let coinLeftLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let coinRightLabel = SKLabelNode(fontNamed: "Courier-Bold")
    var lastUpdateTimeInterval: TimeInterval = 0
    var gameOver = false
    
    override func didMove(to view: SKView) {
        
        // Create entity manager
        
        // Start background music
        let bgMusic = SKAudioNode(fileNamed: SoundFile.BackgroundMusic)
        bgMusic.autoplayLooped = true
        addChild(bgMusic)
        
        // Add background
        let background = SKSpriteNode(imageNamed: ImageName.Background)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
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
        self.addChild(coinLeftLabel)
        
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
        self.addChild(coinRightLabel)
        
        // Add base left
        
        /*
         
         histolyticaButton = ButtonNode(iconName: ImageName.HistolyticaLeft, text: String(GameConfig.HistolyticaCost), onButtonPress: histolyticaPressed)
         histolyticaButton.position = CGPoint(x: size.width * 0.25, y: margin + histolyticaButton.size.height / 2)
         addChild(histolyticaButton)
         
         */
        
        // Add base right
        /*
         
         proteusButton = ButtonNode(iconName: ImageName.ProteusLeft, text: String(GameConfig.ProteusCost), onButtonPress: proteusPressed)
         proteusButton.position = CGPoint(x: size.width * 0.75, y: margin + proteusButton.size.height / 2)
         addChild(proteusButton)
         
         */
        
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
    
    override func update(_ currentTime: TimeInterval) { }
    
    //MARK: - Button methods
    func histolyticaPressed() {
        print("Histolytica pressed!")
    }
    
    func proteusPressed() {
        print("proteus pressed!")
    }
    
    func fowleriPressed() {
        print("fowleri pressed!")
    }
    
}
