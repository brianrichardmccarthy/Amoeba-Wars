//
//  Amoeba.swift
//  Amoeba Wars
//
//  Created by 20063914 on 30/11/2018.
//  Copyright © 2018 Brian McCarthy. All rights reserved.
//

import SpriteKit
import GameplayKit

class Amoeba: GKEntity {
    
    init(team: Team, entityManager: EntityManager, imageName: String, maxSpeed: Float, maxAcceleration: Float) {
        super.init()
        let imageName = imageName
        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(texture: texture)
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        addComponent(MoveComponent(maxSpeed: maxSpeed, maxAcceleration: maxAcceleration, radius: Float(texture.size().width * 0.3), entityManager: entityManager))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
