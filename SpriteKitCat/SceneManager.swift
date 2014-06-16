//
//  SceneManager.swift
//  Sandbox
//
//  Created by Johan Jordaan on 2014/06/11.
//  Copyright (c) 2014 Johan Jordaan. All rights reserved.
//

import Foundation
import SpriteKit

class SceneManager {

    var scenes = Dictionary<String,SceneManagerScene>()
    var view:SKView;
    
    init(view:SKView) {
        self.view = view
    }
    
    // NOTE : Duplicate scenes are overwritten last in is kept
    //
    func registerScene<T:SceneManagerScene>(name:String,scene:T) {
        
        if scene.sceneManager? {
            assert(true,"This scene has alread been registerd in another scene manager")
        }
        
        scene.sceneManager = self
        scene.gotoScene = gotoScene
        scene.name = name
        scenes[name] = scene
    }
    
    func gotoScene(name:String) {
        if let scene = scenes[name] {
            scene.size = view.bounds.size
            view.presentScene(scene)
        } else {
            assert(true,"This scene has not been registered with the SceneManager");
        }
    }
    
    
    var debugInformation = false
    func setDebugInformation(value:Bool) {
        debugInformation = value
        view.showsFPS = debugInformation
        view.showsNodeCount = debugInformation
        view.showsDrawCount = debugInformation
    }
    func toggleDebugInformation() {
        setDebugInformation(!debugInformation)
    }
    
    func enabledDebugInformation() {
        setDebugInformation(true)
    }
    
    func disableDebugInformation() {
        setDebugInformation(false)
    }
}
