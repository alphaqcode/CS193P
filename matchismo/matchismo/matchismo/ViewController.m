//
//  ViewController.m
//  matchismo
//
//  Created by duxiaohui on 14-8-28.
//  Copyright (c) 2014年 duxiaohui. All rights reserved.
//

#import "ViewController.h"
//#import "PlayingCardDeck.h"
#import "CardMatchGame.h"



@interface ViewController ()


@property (strong, nonatomic) CardMatchGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

@end


@implementation ViewController

- (CardMatchGame *)game
{
    if (!_game) _game = [[CardMatchGame alloc] initWithCardCount:[self.cardButton count]
                                                       usingDeck:[self createDeck]];
    return _game;
}


-(Deck *)createDeck     //abstract
{
    return nil;
    //[[PlayingCardDeck alloc] init];
}




- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButton indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton1 in self.cardButton) {
        NSUInteger cardButtonIndex = [self.cardButton indexOfObject:cardButton1];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton1 setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton1 setBackgroundImage:[self backgroudImageForCard:card] forState:UIControlStateNormal];
        cardButton1.enabled = !card.isMatch;
        self.scoreLable.text = [NSString stringWithFormat:@"Score: %lu",self.game.score];
    }
}
         
- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroudImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}


@end

