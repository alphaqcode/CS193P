//
//  Card.h
//  matchismo
//
//  Created by duxiaohui on 14-8-28.
//  Copyright (c) 2014年 duxiaohui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString *contents;

@property (nonatomic,getter=isChosen) BOOL chosen;
@property (nonatomic,getter=isMatch) BOOL matched;

- (int)match: (NSArray *)otherCards;

@end
