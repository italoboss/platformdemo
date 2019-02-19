//
//  PhysicsDetection.swift
//  PlatformDemo
//
//  Created by Italo Boss on 18/02/19.
//  Copyright © 2019 Italo Boss. All rights reserved.
//

import SpriteKit
import GameplayKit

struct ColliderType {
    static let PLAYER: UInt32 = 0x1 << 0
    static let GROUND: UInt32 = 0x1 << 1
}

class PhysicDetection: NSObject, SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == ColliderType.PLAYER | ColliderType.GROUND {
            if let player = contact.bodyA.node as? CharacterNode ?? contact.bodyB.node as? CharacterNode {
                player.grounded = true
            }
        }
    }
    
}


