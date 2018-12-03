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
    
    enum Amoeba {
        case Proteus, Fowleri, Histolytica
    }
    
    lazy var componentSystems: [GKComponentSystem] = {
        let baseSystem = GKComponentSystem(componentClass: BaseComponent.self)
        let moveSystem = GKComponentSystem(componentClass: MoveComponent.self)
        return [baseSystem, moveSystem]
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
    
    func spawnFowleri(team: Team) {
        guard let teamEntity = base(for: team),
            let teamBaseComponent = teamEntity.component(ofType: BaseComponent.self),
            let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
                return
        }
        
        if teamBaseComponent.coins < GameConfig.FowleriCost {
            return
        }
        teamBaseComponent.coins -= GameConfig.FowleriCost
        scene.run(SoundManager.sharedInstance.soundSpawn)
        
        let amoeba = Fowleri(team: team, entityManager: self)
        if let spriteComponent = amoeba.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
            spriteComponent.node.zPosition = Layer.Amoeba
        }
        add(amoeba)
    }
    
    func spawnProteus(team: Team) {
        guard let teamEntity = base(for: team),
            let teamBaseComponent = teamEntity.component(ofType: BaseComponent.self),
            let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
                return
        }
        
        if teamBaseComponent.coins < GameConfig.ProteusCost {
            return
        }
        teamBaseComponent.coins -= GameConfig.ProteusCost
        scene.run(SoundManager.sharedInstance.soundSpawn)
        
        let amoeba = Proteus(team: team, entityManager: self)
        if let spriteComponent = amoeba.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
            spriteComponent.node.zPosition = Layer.Amoeba
        }
        add(amoeba)
    }
    
    func spawnAmoeba(team: Team, amoebaType: Amoeba) {
        guard let teamEntity = base(for: team),
            let teamBaseComponent = teamEntity.component(ofType: BaseComponent.self),
            let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
                return
        }
        
        if teamBaseComponent.coins < GameConfig.ProteusCost {
            return
        }
        
        var amoeba: Amoeba?
        
        switch amoebaType {
        case .Fowleri:
            amoeba = Amoeba(team: team, entityManager: self, imageName: team.rawValue=="Left" ? ImageName.ProteusLeft : ImageName.ProteusRight)
        case .Histolytica:
            amoeba = Amoeba(team: team, entityManager: self)
        case .Proteus:
            amoeba = Amoeba(team: team, entityManager: self)
        }
        
        teamBaseComponent.coins -= GameConfig.ProteusCost
        scene.run(SoundManager.sharedInstance.soundSpawn)
        
        // let amoeba = Proteus(team: team, entityManager: self)
        if let spriteComponent = amoeba.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
            spriteComponent.node.zPosition = Layer.Amoeba
        }
        add(amoeba)
    }
    
    func spawnHistolytica(team: Team) {
        guard let teamEntity = base(for: team),
            let teamBaseComponent = teamEntity.component(ofType: BaseComponent.self),
            let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
                return
        }
        
        if teamBaseComponent.coins < GameConfig.HistolyticaCost {
            return
        }
        teamBaseComponent.coins -= GameConfig.HistolyticaCost
        scene.run(SoundManager.sharedInstance.soundSpawn)
        
        let amoeba = Histolytica(team: team, entityManager: self)
        if let spriteComponent = amoeba.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
            spriteComponent.node.zPosition = Layer.Amoeba
        }
        add(amoeba)
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
