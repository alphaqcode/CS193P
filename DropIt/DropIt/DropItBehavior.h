//
//  DropItBehavior.h
//  DropIt
//
//  Created by 杜晓辉 on 15/5/12.
//  Copyright (c) 2015年 杜晓辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropItBehavior : UIDynamicBehavior

- (void)addItem: (id <UIDynamicItem>) item;
- (void)removeItem: (id <UIDynamicItem>) item;

@end
