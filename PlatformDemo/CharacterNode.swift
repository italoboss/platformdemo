//
//  CharacterNode.swift
//  PlatformDemo
//
//  Created by Italo Boss on 18/02/19.
//  Copyright © 2019 Italo Boss. All rights reserved.
//

import GameplayKit
import SpriteKit

class CharacterNode: SKSpriteNode {
    
    var left = false
    var right = false
    var down = false
    
    var jump = false
    var landed = false
    var grounded = false
    
    var hSpeed: CGFloat = 0.0
    let walkSpeed: CGFloat = 2.0
    
    let maxJump: CGFloat = 40.0
    let airAccel: CGFloat = 0.1
    let airDecel: CGFloat = 0.0
    let groundAccel: CGFloat = 0.2
    let groundDecel: CGFloat = 0.5
    
    var facing: CGFloat = 1.0
    
    var stateMachine: GKStateMachine?
    
    func setUpStateMachine() {
        let normalState = NormalState(with: self)
        stateMachine = GKStateMachine(states: [normalState])
        stateMachine?.enter(NormalState.self)
    }
    
}
