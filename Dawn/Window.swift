//
//  Window.swift
//  Dawn
//
//  Created by Rachel Brindle on 1/12/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

class Window: SCNNode, Procedural {
    var building : Building
    
    var width: CGFloat = 0.75 // meters
    var length: CGFloat = 1 // meters
    
    var lightColor: AnyObject = Color.whiteColor()
    
    func generate() {
        let geometry = SCNPlane(width: width, height: length)
        
        let mat = SCNMaterial()
        mat.emission.contents = lightColor
    }
    
    init(building: Building) {
        self.building = building
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
