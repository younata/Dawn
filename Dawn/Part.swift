//
//  Part.swift
//  Dawn
//
//  Created by Rachel Brindle on 9/4/14.
//  Copyright (c) 2014 Rachel Brindle. All rights reserved.
//

import SceneKit

class Part: SCNNode {
    var attachPoints : [(axis: SCNVector3, anchor: SCNVector3)] = []
    
    var subParts : [Part] {
        var ret : [Part] = []
        for cn in self.childNodes {
            if let sp = cn as? Part {
                ret.append(sp)
            }
        }
        return ret
    }
    
    func attachPart(part: Part, toPointIndex idx0: Int, partPointIndex idx1: Int) -> SCNPhysicsSliderJoint {
        let ap0 = attachPoints[idx0]
        let ap1 = part.attachPoints[idx1]
        self.addChildNode(part)
        let joint = SCNPhysicsSliderJoint(bodyA: self.physicsBody, axisA: ap0.axis, anchorA: ap0.anchor, bodyB: part.physicsBody, axisB: ap1.axis, anchorB: ap1.anchor)
        joint.minimumLinearLimit = 0.0
        joint.maximumLinearLimit = 0.0
        joint.minimumAngularLimit = 0.0
        joint.maximumAngularLimit = 0.0
        return joint
    }
}
