//
//  TouchControlInputNode.swift
//  PlatformDemo
//
//  Created by Italo Boss on 15/02/19.
//  Copyright © 2019 Italo Boss. All rights reserved.
//

import SpriteKit

class TouchControlInputNode: SKSpriteNode {
    
    var alphaUnpressed: CGFloat = 0.5
    var alphaPressed: CGFloat = 0.9
    
    var pressedButtons = [SKSpriteNode]()
    
    let buttonUp = SKSpriteNode(imageNamed: "up_button")
    let buttonRight = SKSpriteNode(imageNamed: "right_button")
    let buttonDown = SKSpriteNode(imageNamed: "down_button")
    let buttonLeft = SKSpriteNode(imageNamed: "left_button")
    
    let buttonX = SKSpriteNode(imageNamed: "x_button")
    let buttonY = SKSpriteNode(imageNamed: "y_button")
    
    weak var inputDelegate: ControlInputDelegate?
    
    init(frame: CGRect) {
        super.init(texture: nil, color: .clear, size: frame.size)
        setupControllers(size: frame.size)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupControllers(size: CGSize) {
        addButton(button: buttonUp, position: CGPoint(x: -(size.width)/3, y: -(size.height)/4 + 50), name: "up", scale: 1.2)
        addButton(button: buttonRight, position: CGPoint(x: -(size.width)/3 + 50, y: -(size.height)/4), name: "right", scale: 1.2)
        addButton(button: buttonDown, position: CGPoint(x: -(size.width)/3, y: -(size.height)/4 - 50), name: "down", scale: 1.2)
        addButton(button: buttonLeft, position: CGPoint(x: -(size.width)/3 - 50, y: -(size.height)/4), name: "left", scale: 1.2)
        
        addButton(button: buttonY, position: CGPoint(x: (size.width)/3 + 50, y: -(size.height)/4), name: "Y", scale: 1.2)
        addButton(button: buttonX, position: CGPoint(x: (size.width)/3, y: -(size.height)/4 - 50), name: "X", scale: 1.2)
    }
    
    func addButton(button: SKSpriteNode, position: CGPoint, name: String, scale: CGFloat) {
        button.position = position
        button.name = name
        button.setScale(scale)
        button.zPosition = 10
        button.alpha = alphaUnpressed
        self.addChild(button)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: parent!)
            for button in [buttonUp, buttonRight, buttonDown, buttonLeft, buttonX, buttonY] {
                if button.contains(location) && !pressedButtons.contains(button) {
                    pressedButtons.append(button)
                    inputDelegate?.follow(command: button.name)
                }
                
                if pressedButtons.contains(button) {
                    button.alpha = alphaPressed
                }
                else {
                    button.alpha = alphaUnpressed
                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let previous = touch.previousLocation(in: parent!)
            let location = touch.location(in: parent!)
            
            for button in [buttonUp, buttonRight, buttonDown, buttonLeft, buttonX, buttonY] {
                
                if button.contains(previous) && !button.contains(location) {
                    if let index = pressedButtons.index(of: button) {
                        pressedButtons.remove(at: index)
                        inputDelegate?.follow(command: "stop_\(button.name!)")
                    }
                }
                else if button.contains(location) && !pressedButtons.contains(button) {
                    pressedButtons.append(button)
                    inputDelegate?.follow(command: button.name)
                }
                
                if pressedButtons.contains(button) {
                    button.alpha = alphaPressed
                }
                else {
                    button.alpha = alphaUnpressed
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchUp(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchUp(touches, with: event)
    }
    
    func touchUp(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let previous = touch.previousLocation(in: parent!)
            let location = touch.location(in: parent!)
            
            for button in [buttonUp, buttonRight, buttonDown, buttonLeft, buttonX, buttonY] {
                
                if button.contains(previous) || button.contains(location) {
                    if let index = pressedButtons.index(of: button) {
                        pressedButtons.remove(at: index)
                        inputDelegate?.follow(command: "cancel_\(button.name!)")
                    }
                }
                else if button.contains(location) && !pressedButtons.contains(button) {
                    pressedButtons.append(button)
                    inputDelegate?.follow(command: button.name)
                }
                
                if pressedButtons.contains(button) {
                    button.alpha = alphaPressed
                }
                else {
                    button.alpha = alphaUnpressed
                }
            }
        }
    }
    
}
