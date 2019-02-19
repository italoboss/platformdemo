//
//  PlayerControlComponent.swift
//  PlatformDemo
//
//  Created by Italo Boss on 15/02/19.
//  Copyright © 2019 Italo Boss. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerControlComponent: GKComponent, ControlInputDelegate {
    
    var touchControlNode: TouchControlInputNode?
    var characterNode: CharacterNode?
    
    func setupControls(camera: SKCameraNode, scene: SKScene) {
        touchControlNode = TouchControlInputNode(frame: scene.frame)
        touchControlNode?.inputDelegate = self
        touchControlNode?.position = CGPoint.zero
        
        camera.addChild(touchControlNode!)
        
        if characterNode == nil {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                characterNode = nodeComponent.node as? CharacterNode
            }
        }
    }
    
    func follow(command: String?) {
        if let cNode = characterNode, let command = command {
            switch command {
            case "left":
                cNode.left = true
            case "cancel_left", "stop_left":
                cNode.left = false
            case "right":
                cNode.right = true
            case "cancel_right", "stop_right":
                cNode.right = false
            case "X":
                cNode.jump = true
            case "cancel_X", "stop_X":
                cNode.jump = false
            default:
                print("Follow command: \(String(describing: command))")
            }
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        characterNode?.stateMachine?.update(deltaTime: seconds)
    }
    
}
