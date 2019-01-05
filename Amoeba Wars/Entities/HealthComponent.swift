//
//  MoveComponent.swift
//  Amoeba Wars
//
//  Created by 20063914 on 28/11/2018.
//  Copyright © 2018 Brian McCarthy. All rights reserved.
//

import SpriteKit
import GameplayKit

class HealthComponent : GKAgent2D, GKAgentDelegate {
    
    let entityManager: EntityManager
    var health: Int
    var damage: Int
    
    init(health: Int, damage: Int, entityManager: EntityManager) {
        self.entityManager = entityManager
        self.health = health
        self.damage = damage
        super.init()
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func agentWillUpdate(_ agent: GKAgent) {
        
    }
    
    func agentDidUpdate(_ agent: GKAgent) {
        
    }
    
    func takeDamage(damage: Int) {
        health -= damage
    }
    
    func isDead() -> Bool {
        return health <= 0
    }
    
    override func update(deltaTime seconds: TimeInterval) {
    }
}
