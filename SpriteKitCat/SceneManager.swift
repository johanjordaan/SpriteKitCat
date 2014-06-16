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
}
