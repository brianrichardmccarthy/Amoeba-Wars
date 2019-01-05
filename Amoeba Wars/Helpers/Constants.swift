//
//  Constants.swift
//  Amoeba Wars
//
//  Created by 20063914 on 23/11/2018.
//  Copyright © 2018 Brian McCarthy. All rights reserved.
//

import Foundation
import SpriteKit


import UIKit

struct ImageName {
    static let Background = "Background"
    static let Button = "Button.png";
    static let HistolyticaLeft = "HistolyticaLeft.png";
    static let HistolyticaRight = "HistolyticaRight.png";
    static let FowleriLeft = "FowleriLeft.png";
    static let FowleriRight = "FowleriRight.png";
    static let ProteusRight = "ProteusRight.png";
    static let ProteusLeft = "ProteusLeft.png";
    static let Coin = "Coin.png";
    static let BaseLeftDefence = "Base_Left_Defence.png";
    static let BaseRightDefence = "Base_Right_Defence.png";
    static let Base_Left_Attack = "Base_Left_Attack.png";
    static let Base_Right_Attack = "Base_Right_Attack.png";
    static let Heart = "heart-full.png"
}

struct Layer {
    static let Background: CGFloat = 0
    static let Button: CGFloat = 1;
    static let HUD: CGFloat = 2;
    static let Amoeba: CGFloat = 3;
}

struct PhysicsCategory {
}

struct GameConfig {
    static let HistolyticaCost = 10
    static let FowleriCost = 25
    static let ProteusCost = 50
}
