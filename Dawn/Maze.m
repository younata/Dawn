//
//  Maze.m
//  Dawn
//
//  Created by Rachel Brindle on 8/7/14.
//  Copyright (c) 2014 Rachel Brindle. All rights reserved.
//

#import "Maze.h"

@implementation Cell

- (instancetype)init
{
    if ((self = [super init])) {
        self.right = true;
        self.left = true;
        self.up = true;
        self.down = true;
    }
    return self;
}

- (void)knockDownWall:(NSInteger)wall
{
    switch (wall) {
        case 1:
            self.right = false;
            break;
        case 2:
            self.down = false;
            break;
        case 3:
            self.left = false;
            break;
        case 4:
            self.up = false;
            break;
        default:
            break;
    }
}

- (BOOL)hasAllWallsIntact
{
    return self.right && self.left && self.up && self.down;
}

@end

@implementation Maze

- (NSArray *)getNeighborsWithWallsIntact:(NSArray *)center
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for (NSArray *c in [self getNeighborsOfCell:center]) {
        if ([[self getCell:c] hasAllWallsIntact]) {
            [ret addObject:c];
        }
    }
    return [NSArray arrayWithArray:ret];
}

- (NSArray *)getNeighborsOfCell:(NSArray *)cell
{
    NSInteger width = self.cells.count;
    NSInteger height = [self.cells[0] count];
    
    NSInteger x = [cell[0] integerValue];
    NSInteger y = [cell[1] integerValue];
    
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    
    if (x < (width - 1)) {
        [ret addObject:@[@(x+1), @(y)]];
    }
    if (y < (height - 1)) {
        [ret addObject:@[@(x), @(y+1)]];
    }
    if (x > 0) {
        [ret addObject:@[@(x-1), @(y)]];
    }
    if (y > 0) {
        [ret addObject:@[@(x), @(y-1)]];
    }
    
    return [NSArray arrayWithArray:ret];
}

- (Cell *)getCell:(NSArray *)coords
{
    NSInteger x = [coords[0] integerValue];
    NSInteger y = [coords[1] integerValue];
    return self.cells[x][y];
}

- (NSInteger)getBorderBetweenCells:(NSArray *)cell1 cell2:(NSArray *)cell2
{
    NSInteger x1 = [cell1[0] integerValue];
    NSInteger x2 = [cell2[0] integerValue];
    NSInteger y1 = [cell1[1] integerValue];
    NSInteger y2 = [cell2[1] integerValue];
    
    if (x1 == (x2 + 1) && y1 == y2) {
        return 1;
    } else if (x1 == x2 && y1 == (y2 + 1)) {
        return 2;
    } else if (x1 == (x2 - 1) && y1 == y2) {
        return 3;
    } else if (x1 == x2 && y1 == (y2 - 1)) {
        return 4;
    }
    
    return 0;
}

- (instancetype)initWithHeight:(NSInteger)height width:(NSInteger)width
{
    if ((self = [super init])) {
        self.height = height;
        self.width = width;
        
        NSMutableArray *cells = [[NSMutableArray alloc] initWithCapacity:width];
        for (NSInteger i = 0; i < width; i++) {
            NSMutableArray *c = [[NSMutableArray alloc] initWithCapacity:height];
            for (NSInteger j = 0; j < height; j++) {
                [c addObject:[[Cell alloc] init]];
            }
            [cells addObject:[NSArray arrayWithArray:c]];
        }
        self.cells = [NSArray arrayWithArray:cells];
        
        NSMutableArray *stack = [[NSMutableArray alloc] init];
        NSInteger visitedCells = 1;
        
        NSInteger totalCells = width * height;
        NSInteger cid = arc4random_uniform(totalCells);
        NSArray *currentCell = @[@(cid / height), @(cid % height)];
        
        while (visitedCells < totalCells) {
            NSArray *neighbors = [self getNeighborsWithWallsIntact:currentCell];
            Cell *c = [self getCell:currentCell];
            if (neighbors.count > 0) {
                NSArray *nc = neighbors[arc4random_uniform(neighbors.count)];
                Cell *n = [self getCell:nc];
                [c knockDownWall:[self getBorderBetweenCells:currentCell cell2:nc]];
                [n knockDownWall:[self getBorderBetweenCells:nc cell2:currentCell]];
                
                [stack addObject:currentCell];
                currentCell = nc;
                visitedCells++;
            } else {
                currentCell = stack.firstObject;
                [stack removeObjectAtIndex:0];
            }
        }
        
    }
    return self;
}

@end
