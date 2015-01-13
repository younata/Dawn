//
//  CityScape.swift
//  Dawn
//
//  Created by Rachel Brindle on 1/11/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

#if os(iOS)
    typealias Color = UIColor
    #elseif os(OSX)
    typealias Color = NSColor
#endif

class CityScape: SCNNode, Procedural {
    // a city is a node
    
    var buildings : [Building] = []
    
    func generate() {
        
    }
}
