//
//  DropItBehavior.m
//  DropIt
//
//  Created by 杜晓辉 on 15/5/12.
//  Copyright (c) 2015年 杜晓辉. All rights reserved.
//

#import "DropItBehavior.h"

@interface DropItBehavior ()

@property (strong,nonatomic) UIGravityBehavior *gravity;
@property (strong,nonatomic) UICollisionBehavior *collider;

@end

@implementation DropItBehavior

-(UIGravityBehavior *)behavior{
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc]init];
        _gravity.magnitude = 0.9;
    }
    return _gravity;
}

-(UICollisionBehavior *)collider {
    if (!_collider) {
        _collider = [[UICollisionBehavior alloc] init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collider;
}

- (void)addItem: (id <UIDynamicItem>) item{
    [self.gravity addItem:item];
    [self.collider addItem:item];
    
}
- (void)removeItem: (id <UIDynamicItem>) item{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
}


-(instancetype)init{
    self = [super init];
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    return self;
    
}

@end
