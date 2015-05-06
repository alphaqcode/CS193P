//
//  Deck.h
//  matchismo
//
//  Created by duxiaohui on 14-8-28.
//  Copyright (c) 2014年 duxiaohui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;   


@end
