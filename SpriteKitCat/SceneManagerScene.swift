//
//  SceneManagerScene.swift
//  Sandbox
//
//  Created by Johan Jordaan on 2014/06/12.
//  Copyright (c) 2014 Johan Jordaan. All rights reserved.
//

import Foundation
import SpriteKit

class SceneManagerScene : SKScene {
   
    var gotoScene:((String)->Void) = { (String)->Void in
        assert(true,"This scene has not been registered with the SceneManager");
    }
    
    var shapeNodeFactory:NodeFactory<SKShapeNode> = NodeFactory<SKShapeNode>()
    var spriteNodeFactory:NodeFactory<SKSpriteNode> = NodeFactory<SKSpriteNode>()
    
    // All scene nodes are added to the world node which is added to the scene
    //
    var world:SKNode? = nil
    var camera:SKNode? = nil
    override func addChild(node: SKNode!){
        if !world? {
            world = SKNode()
            super.addChild(world)
        }
        
        if !camera? {
            camera = SKNode()
            camera!.position = CGPointMake(size.width/2, size.height/2)
            world!.addChild(camera)
        }
        
        world!.addChild(node);
    }
    
    func centerOnCamera() {
        if camera? {
            var cameraPositionInScene = convertPoint(camera!.position, fromNode: camera!.parent)
            let x:CGFloat = camera!.parent.position.x - cameraPositionInScene.x + size.width/2
            let y:CGFloat = camera!.parent.position.y - cameraPositionInScene.y + size.height/2
            world!.position = CGPointMake(x,y)
        }
    }
    
    override func didSimulatePhysics() {
        centerOnCamera()
    }
    
    override func didMoveToView(view: SKView!) {
        //var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        //self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        super.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        //super.touchesEnded(touches, withEvent: event)
        var touch = touches.allObjects
        
        for touch in touches.allObjects as UITouch[] {
            var location = touch.locationInNode(self)
            var touchedNode = nodeAtPoint(location)
            if touchedNode? {
                if touchedNode.userData? {
                    if let vm = touchedNode.userData["ViewModel"] as? ViewModel {
                        vm.onClick();
                    }
                }
            }
        }
    }
    

    
    
    /*func handlePan(recognizer:UIPanGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Began {
        } else if recognizer.state == UIGestureRecognizerState.Changed {
            var translation =  recognizer.translationInView(recognizer.view)
            var x = (-5)*translation.x+camera!.position.x
            var y = (-5)*(-1*translation.y)+camera!.position.y
            translation = CGPointMake(x,y)
    
    
            var moveBy =  SKAction.moveTo(translation, duration: 0.1)
            camera!.runAction(moveBy)
            recognizer.setTranslation(CGPointZero, inView: recognizer.view)
    
        } else if (recognizer.state == UIGestureRecognizerState.Ended) {
        }
    }*/
    
    
    
    /*var lastUpdateTimeInterval:CFTimeInterval? = nil
    override func update(currentTime: NSTimeInterval)  {
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    //
    if !lastUpdateTimeInterval? {
    lastUpdateTimeInterval = currentTime
    return
    }
    var timeSinceLast = currentTime - lastUpdateTimeInterval!;
    lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
    timeSinceLast = 1.0 / 60.0;
    self.lastUpdateTimeInterval = currentTime;
    }
    updateWithTimeSinceLastUpdate(timeSinceLast)
    }
    
    func updateWithTimeSinceLastUpdate(timeSinceLast:CFTimeInterval) {
    }*/
    
}