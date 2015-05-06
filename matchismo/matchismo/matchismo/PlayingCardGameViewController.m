//
//  PlayingCardGameViewController.m
//  matchismo
//
//  Created by duxiaohui on 14-9-7.
//  Copyright (c) 2014年 duxiaohui. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
