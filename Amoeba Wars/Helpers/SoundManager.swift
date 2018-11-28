//
//  Sound.swift
//  Amoeba Wars
//
//  Created by 20063914 on 23/11/2018.
//  Copyright © 2018 Brian McCarthy. All rights reserved.
//

import Foundation
import SpriteKit

struct SoundFile {
    static let BackgroundMusic = "Latin_Industries.mp3"
}

class SoundManager {
    
    let soundPew = SKAction.playSoundFileNamed("pew.wav", waitForCompletion: false)
    let soundPew2 = SKAction.playSoundFileNamed("pew2.wav", waitForCompletion: false)
    let soundBoom = SKAction.playSoundFileNamed("boom.wav", waitForCompletion: false)
    let soundSpawn = SKAction.playSoundFileNamed("spawn.wav", waitForCompletion: false)
    let soundAttack = SKAction.playSoundFileNamed("attack.wav", waitForCompletion: false)
    let soundDefend = SKAction.playSoundFileNamed("defend.wav", waitForCompletion: false)
    let soundBigHit = SKAction.playSoundFileNamed("bigHit.wav", waitForCompletion: false)
    let soundSmallHit = SKAction.playSoundFileNamed("smallHit.wav", waitForCompletion: false)
    
    static let sharedInstance = SoundManager()
    
}
