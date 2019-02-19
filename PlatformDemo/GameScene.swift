//
//  GameScene.swift
//  PlatformDemo
//
//  Created by Italo Boss on 15/02/19.
//  Copyright © 2019 Italo Boss. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()
    var physicsDelegate = PhysicDetection()
    
    private var lastUpdateTime: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        print("didMove!")
        if let player = childNode(withName: "Player") {
            if let characterNode = player as? CharacterNode {
                characterNode.setUpStateMachine()
            }
            if let playerComponent = player.entity?.component(ofType: PlayerControlComponent.self) {
                playerComponent.setupControls(camera: camera!, scene: self)
            }
        }
        
        self.physicsWorld.contactDelegate = physicsDelegate
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }
        
        let dt = currentTime - lastUpdateTime
        
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
}
