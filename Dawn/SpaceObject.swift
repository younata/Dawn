//
//  SpaceObject.swift
//  Dawn
//
//  Created by Rachel Brindle on 9/4/14.
//  Copyright (c) 2014 Rachel Brindle. All rights reserved.
//

import UIKit
import SceneKit

class SpaceObject {
    
    var onRails : Bool = false {
        didSet {
            if onRails == oldValue && node.physicsBody != nil {
                return
            }
            if onRails {
                node.physicsBody = SCNPhysicsBody.staticBody()
            } else {
                node.physicsBody = SCNPhysicsBody.dynamicBody()
            }
            node.physicsBody?.mass = CGFloat(mass)
        }
    }
    
    let allowsOrbitingBodies = true
    
    var node : SCNNode = SCNNode() {
        didSet {
            node.physicsField = nil
            if allowsOrbitingBodies {
                node.physicsField = SCNPhysicsField.radialGravityField()
            }
        }
    }
    
    var mass : Double = 0.0 {
        didSet {
            self.node.physicsBody?.mass = CGFloat(mass)
        }
    }
    
    var name : String = ""
    
    // I'll worry about orbit objects about when a secondary stationary object is created...
    
    init(mass: Double, sceneFile: String, name: String) {
        let scene = SCNScene(named: sceneFile)
        self.node = scene.rootNode
        self.name = name;
        self.mass = mass;
        self.onRails = false
    }
    
    /*
    inits:
    mass, scene file, name
    subobjects (e.g. cities, buildings, etc.) (later)
    
    */
}
