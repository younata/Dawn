//
//  Game.m
//  Dawn
//
//  Created by Rachel Brindle on 8/7/14.
//  Copyright (c) 2014 Rachel Brindle. All rights reserved.
//

#import "Game.h"
#import "Maze.h"

#define M_TAU (2.0 * M_PI)

SCNNode *createPlaneNode()
{
    return [SCNNode nodeWithGeometry:[SCNPlane planeWithWidth:3 height:3]];
}

@implementation Game

- (SCNNode *)createCell:(Cell *)cell
{
    SCNNode *rootNode = [SCNNode node];
    rootNode.physicsBody = [SCNPhysicsBody staticBody];
    rootNode.castsShadow = YES;
    
    double rot = 0.25 * M_TAU;
    
    SCNNode *(^createNode)() = ^SCNNode *(){
        SCNNode *n = createPlaneNode();
        [rootNode addChildNode:n];
        n.physicsBody = [SCNPhysicsBody staticBody];
        n.castsShadow = YES;
        SCNMaterial *mat = [SCNMaterial material];
        mat.ambient.contents = [UIColor darkGrayColor];
        n.geometry.materials = @[mat];
        return n;
    };
    
    if (cell.right) {
        SCNNode *n = createNode();
        n.eulerAngles = SCNVector3Make(0, 0, rot);
        n.position = SCNVector3Make(1.5, 0, 0);
    }
    if (cell.down) {
        SCNNode *n = createNode();
        n.eulerAngles = SCNVector3Make(0, rot, rot);
        n.position = SCNVector3Make(0, 0, -1.5);
    }
    if (cell.left) {
        SCNNode *n = createNode();
        n.eulerAngles = SCNVector3Make(0, 0, rot);
        n.position = SCNVector3Make(-1.5, 0, 0);
    }
    if (cell.up) {
        SCNNode *n = createNode();
        n.eulerAngles = SCNVector3Make(0, rot, rot);
        n.position = SCNVector3Make(0, 0, 1.5);
    }
    return [rootNode flattenedClone];
}

- (void)setPlayerVelocity:(SCNVector3)velocity
{
    self.playerNode.physicsBody.velocity = velocity;
}

- (void)setPlayerAngularVelocity:(SCNVector4)angularVelocity
{
    self.playerNode.physicsBody.angularVelocity = angularVelocity;
}

- (instancetype)init
{
    if ((self = [super init])) {
        double width = 10, height = 10;
        NSInteger conv = 10;
        self.scene = [SCNScene scene];
        
        self.floorNode = [SCNNode nodeWithGeometry:[SCNPlane planeWithWidth:width height:height]];
        [self.scene.rootNode addChildNode:self.floorNode];
        
        self.playerNode = [SCNNode nodeWithGeometry:[SCNBox boxWithWidth:0.25 height:1.67 length:0.25 chamferRadius:0.0]];
        
        Maze *maze = [[Maze alloc] initWithHeight:height width:width];
        NSArray *cells = maze.cells;
        for (NSInteger x = 0; x < cells.count; x++) {
            NSArray *sc = cells[x];
            for (NSInteger y = 0; y < sc.count; y++) {
                SCNNode *node = [self createCell:sc[y]];
                [self.floorNode addChildNode:node];
                node.position = SCNVector3Make(x * conv, 0, y * conv);
            }
        }
        
        self.playerNode.position = SCNVector3Make(1.5, 0, 1.5);
        self.playerNode.camera = [SCNCamera camera];
        [self.floorNode addChildNode:self.playerNode];
        self.playerNode.physicsBody = [SCNPhysicsBody kinematicBody];
        
        SCNNode *ambientLightNode = [SCNNode node];
        ambientLightNode.light = [SCNLight light];
        ambientLightNode.light.type = SCNLightTypeAmbient;
        ambientLightNode.light.color = [UIColor darkGrayColor];
        [self.scene.rootNode addChildNode:ambientLightNode];
    }
    return self;
}

@end
