//
//  EntityManager.swift
//  Amoeba Wars
//
//  Created by 20063914 on 28/11/2018.
//  Copyright © 2018 Brian McCarthy. All rights reserved.
//

import SpriteKit
import GameplayKit

class EntityManager {
    
    enum AmoebaType {
        case Proteus, Fowleri, Histolytica
    }
    
    lazy var componentSystems: [GKComponentSystem] = {
        let baseSystem = GKComponentSystem(componentClass: BaseComponent.self)
        let moveSystem = GKComponentSystem(componentClass: MoveComponent.self)
        let heathSystem = GKComponentSystem(componentClass: HealthComponent.self)
        return [baseSystem, moveSystem, heathSystem]
    }()
    
    var toRemove = Set<GKEntity>()
    var entities = Set<GKEntity>()
    let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
        
    }
    
    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        
        entities.remove(entity)
        toRemove.insert(entity)
    }
    
    func base(for team: Team) -> GKEntity? {
        for entity in entities {
            if let teamComponent = entity.component(ofType: TeamComponent.self),
                let _ = entity.component(ofType: BaseComponent.self) {
                if teamComponent.team == team {
                    return entity
                }
            }
        }
        return nil
    }
    
    func spawnAmoeba(team: Team, amoebaType: AmoebaType) {
        guard let teamEntity = base(for: team),
            let teamBaseComponent = teamEntity.component(ofType: BaseComponent.self),
            let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
                return
        }
        
        var amoeba: Amoeba?
        
        switch amoebaType {
            case .Fowleri:
                if teamBaseComponent.coins < GameConfig.FowleriCost {
                    return
                }
                amoeba = Amoeba(team: team, entityManager: self, imageName: team.rawValue=="Left" ? ImageName.FowleriLeft : ImageName.FowleriRight, maxSpeed: 150, maxAcceleration: 5)
                teamBaseComponent.coins -= GameConfig.FowleriCost
                amoeba?.addComponent(HealthComponent(health: 40, damage: 15, entityManager: self))
            case .Histolytica:
                if teamBaseComponent.coins < GameConfig.HistolyticaCost {
                    return
                }
                amoeba = Amoeba(team: team, entityManager: self, imageName: team.rawValue=="Left" ? ImageName.HistolyticaLeft : ImageName.HistolyticaRight, maxSpeed: 150, maxAcceleration: 5)
                teamBaseComponent.coins -= GameConfig.HistolyticaCost
                amoeba?.addComponent(HealthComponent(health: 60, damage: 20, entityManager: self))
            case .Proteus:
                if teamBaseComponent.coins < GameConfig.ProteusCost {
                    return
                }
                amoeba = Amoeba(team: team, entityManager: self, imageName: team.rawValue=="Left" ? ImageName.ProteusLeft : ImageName.ProteusRight, maxSpeed: 150, maxAcceleration: 5)
                teamBaseComponent.coins -= GameConfig.ProteusCost
                amoeba?.addComponent(HealthComponent(health: 100, damage: 25, entityManager: self))
        }
        
        scene.run(SoundManager.sharedInstance.soundSpawn)
        
        if let spriteComponent = amoeba!.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
            spriteComponent.node.zPosition = Layer.Amoeba
        }
        add(amoeba!)
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        
        for currentRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
        }
        toRemove.removeAll()
    }
    
    func entities(for team: Team) -> [GKEntity] {
        return entities.compactMap{ entity in
            if let teamComponent = entity.component(ofType: TeamComponent.self) {
                if teamComponent.team == team {
                    return entity
                }
            }
            return nil
        }
    }
    
    func moveComponents(for team: Team) -> [MoveComponent] {
        let entitiesToMove = entities(for: team)
        var moveComponents = [MoveComponent]()
        for entity in entitiesToMove {
            if let moveComponent = entity.component(ofType: MoveComponent.self) {
                moveComponents.append(moveComponent)
            }
        }
        return moveComponents
    }
    
}
