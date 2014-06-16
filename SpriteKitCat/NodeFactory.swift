//
//  NodeFactory.swift
//  Sandbox
//
//  Created by Johan Jordaan on 2014/06/13.
//  Copyright (c) 2014 Johan Jordaan. All rights reserved.
//

import SpriteKit

class NodeFactory<T:SKNode> {
    
    var nodes:T[] = [];
    
    func alloc() -> T {
        var node:T? = nil
        if nodes.count > 0 {
            node = nodes.removeLast()
        } else {
            node = T()
            (node as SKNode).userData = NSMutableDictionary()
        }
        return node!
    }
    
    func release(node:T) {
        node.removeFromParent()
        nodes.append(node)
    }
    
}
