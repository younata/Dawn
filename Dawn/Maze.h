//
//  Maze.h
//  Dawn
//
//  Created by Rachel Brindle on 8/7/14.
//  Copyright (c) 2014 Rachel Brindle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cell : NSObject

@property (nonatomic) BOOL right;
@property (nonatomic) BOOL down;
@property (nonatomic) BOOL left;
@property (nonatomic) BOOL up;

- (void)knockDownWall:(NSInteger)wall;
- (BOOL)hasAllWallsIntact;

@end

@interface Maze : NSObject

@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger height;
@property (nonatomic) NSArray *cells;

- (instancetype)initWithHeight:(NSInteger)height width:(NSInteger)width;

@end
