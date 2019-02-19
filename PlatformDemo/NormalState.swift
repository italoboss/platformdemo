//
//  NormalState.swift
//  PlatformDemo
//
//  Created by Italo Boss on 18/02/19.
//  Copyright © 2019 Italo Boss. All rights reserved.
//

import GameplayKit

class NormalState: GKState {
    
    var characterNode: CharacterNode
    
    init(with node: CharacterNode) {
        characterNode = node
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        var aSpeed: CGFloat = 0.0
        var dSpeed: CGFloat = 0.0
        
        if characterNode.grounded {
            aSpeed = characterNode.groundAccel
            dSpeed = characterNode.groundDecel
        }
        else {
            aSpeed = characterNode.airAccel
            dSpeed = characterNode.airDecel
        }
        
        if characterNode.left {
            characterNode.facing = -1.0
            characterNode.xScale = -1.0
            characterNode.hSpeed = approach(start: characterNode.hSpeed, end: -characterNode.walkSpeed, shift: aSpeed)
        }
        else if characterNode.right {
            characterNode.facing = 1.0
            characterNode.xScale = 1.0
            characterNode.hSpeed = approach(start: characterNode.hSpeed, end: characterNode.walkSpeed, shift: aSpeed)
        }
        else {
            characterNode.hSpeed = approach(start: characterNode.hSpeed, end: 0.0, shift: dSpeed)
        }
        
        if characterNode.grounded {
            if !characterNode.landed {
                squashAndScretch(xScale: 1.3, yScale: 0.7)
                if let physicsBody = characterNode.physicsBody {
                    characterNode.physicsBody?.velocity = CGVector(dx: physicsBody.velocity.dx, dy: 0.0)
                }
                characterNode.landed = true
            }
            if characterNode.jump {
                characterNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: characterNode.maxJump))
                characterNode.grounded = false
                squashAndScretch(xScale: 0.7, yScale: 1.3)
            }
        }
        else {
            if let dy = characterNode.physicsBody?.velocity.dy {
                if dy < 0.0 {
                    characterNode.jump = false
                }
                if dy > 0.0 && !characterNode.jump {
                    characterNode.physicsBody?.velocity.dy *= 0.5
                }
            }
            characterNode.landed = false
        }
        
        characterNode.xScale = approach(start: characterNode.xScale, end: characterNode.facing, shift: 0.05)
        characterNode.yScale = approach(start: characterNode.yScale, end: 1, shift: 0.05)
        
        characterNode.position.x = characterNode.position.x + characterNode.hSpeed
    }
    
    func approach(start: CGFloat, end: CGFloat, shift: CGFloat) -> CGFloat {
        if start < end {
            return min(start + shift, end)
        }
        else {
            return max(start - shift, end)
        }
    }
    
    func squashAndScretch(xScale: CGFloat, yScale: CGFloat) {
        characterNode.xScale = xScale * characterNode.facing
        characterNode.yScale = yScale
    }
    
}
