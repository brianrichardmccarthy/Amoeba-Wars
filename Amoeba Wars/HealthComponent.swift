//
//  HealthComponent.swift
//  Amoeba Wars
//
//  Created by 20063914 on 05/12/2018.
//  Copyright © 2018 Brian McCarthy. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class HealthComponent : GKComponent {

    var health : Int {
        didSet {
            isDead = health <= 0
        }
    }
    
    let spriteComponent: SpriteComponent
    var isDead: Bool
    
    init(health: Int, spriteComponent: SpriteComponent) {
        self.health = health
        self.spriteComponent = spriteComponent
        isDead = false
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
}
