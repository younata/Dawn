//
//  GameViewController.swift
//  Dawn
//
//  Created by Rachel Brindle on 8/7/14.
//  Copyright (c) 2014 Rachel Brindle. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scnView = SCNView(forAutoLayout: ())
        self.view.addSubview(scnView)
        scnView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
        
        // set the scene to the view
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.blackColor()
    }
}
