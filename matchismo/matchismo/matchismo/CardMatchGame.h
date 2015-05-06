//
//  CardMatchGame.h
//  matchismo
//
//  Created by duxiaohui on 14-8-30.
//  Copyright (c) 2014年 duxiaohui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)NSUInteger score;



@end
