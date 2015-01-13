//
//  Building.swift
//  Dawn
//
//  Created by Rachel Brindle on 1/11/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

// might be better to split this into subclasses, but for now, enums.
class Building: SCNNode, Procedural {
    // A building as pretty much a box with lights coming out of some rectangles
    // on 4 of the 6 sides (neither the top nor bottom sides)
    
    enum BuildingType {
        case Warehouse
        case ApartmentComplex
        case House
        case Factory
        case Office
        case Store
    }
    
    var type : BuildingType = .Office
    
    var width: CGFloat = 10 // meters
    var length: CGFloat = 10 // meters
    var heightAboveGround: CGFloat = 6 // meters, 1 floor = 3 meters.
    var heightBelowGround: CGFloat = 0 // meters, 1 floor = 3 meters.
    var material: AnyObject = Color.grayColor()
    
    var windows: [Window] = []
    
    func generate() {
        let geometry = SCNBox(width: width, height: (heightAboveGround + heightBelowGround), length: length, chamferRadius: 0)
        
        let mat = SCNMaterial()
        mat.ambient.contents = material
        
        geometry.materials = [mat]
        
        self.geometry = geometry
        self.physicsBody = SCNPhysicsBody.staticBody()
        
        // add windows.
        
        switch type {
        case .Warehouse:
            break
        case .ApartmentComplex:
            break
        case .House:
            break
        case .Factory:
            break
        case .Office:
            break
        case .Store:
            break
        }
    }
}
