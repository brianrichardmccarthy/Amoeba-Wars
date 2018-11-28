//
//  SpriteComponent.swift
//  Amoeba Wars
//
//  Created by 20063914 on 28/11/2018.
//  Copyright © 2018 Brian McCarthy. All rights reserved.
//

import SpriteKit
import GameKit

class SpriteComponent : GKComponent {
    let node : SKSpriteNode
    
    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
