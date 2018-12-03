//
//  AIPlayer.swift
//  Amoeba Wars
//
//  Created by 20063914 on 03/12/2018.
//  Copyright © 2018 Brian McCarthy. All rights reserved.
//

import Foundation

class AIPlayer {
    
    var prevous: EntityManager.AmoebaType
    var entityManager: EntityManager
    var spawn: Bool
    
    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        prevous = .Histolytica
        spawn = true
    }
    
    func update(score: Int) {
        
        if (score <= 0) {
            return
        }
        
        let p = drand48()
        
        switch prevous {
        case .Histolytica:
            if p > 0.9 && score >= GameConfig.HistolyticaCost {
                entityManager.spawnAmoeba(team: .teamRight, amoebaType: .Histolytica)
            } else if p > 0.65 && score >= GameConfig.FowleriCost {
                entityManager.spawnAmoeba(team: .teamRight, amoebaType: .Fowleri)
            } else if score >= GameConfig.ProteusCost {
                entityManager.spawnAmoeba(team: .teamRight, amoebaType: .Proteus)
            }
            break
        case .Fowleri:
            if p < 0.7 && score >= GameConfig.HistolyticaCost {
                entityManager.spawnAmoeba(team: .teamRight, amoebaType: .Histolytica)
            } else if p < 0.85 && score >= GameConfig.FowleriCost {
                entityManager.spawnAmoeba(team: .teamRight, amoebaType: .Fowleri)
            } else if score >= GameConfig.ProteusCost {
                entityManager.spawnAmoeba(team: .teamRight, amoebaType: .Proteus)
            }
            break
        case .Proteus:
            if p < 0.6 && score >= GameConfig.HistolyticaCost {
                entityManager.spawnAmoeba(team: .teamRight, amoebaType: .Histolytica)
            } else if p < 0.9 && score >= GameConfig.FowleriCost {
                entityManager.spawnAmoeba(team: .teamRight, amoebaType: .Fowleri)
            } else if score >= GameConfig.ProteusCost {
                entityManager.spawnAmoeba(team: .teamRight, amoebaType: .Proteus)
            }
            break
        }
        
    }
    
}
