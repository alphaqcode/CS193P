//
//  PlayingCard.h
//  matchismo
//
//  Created by duxiaohui on 14-8-28.
//  Copyright (c) 2014年 duxiaohui. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
