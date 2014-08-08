//
//  Game.h
//  Dawn
//
//  Created by Rachel Brindle on 8/7/14.
//  Copyright (c) 2014 Rachel Brindle. All rights reserved.
//

#import <Foundation/Foundation.h>
@import SceneKit;

@interface Game : NSObject

@property (nonatomic, strong) SCNNode *playerNode;
@property (nonatomic, strong) SCNNode *floorNode;
@property (nonatomic, strong) SCNScene *scene;

- (void)setPlayerVelocity:(SCNVector3)velocity;
- (void)setPlayerAngularVelocity:(SCNVector4)angularVelocity;

@end
