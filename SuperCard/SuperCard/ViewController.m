//
//  ViewController.m
//  SuperCard
//
//  Created by duxiaohui on 14-9-25.
//  Copyright (c) 2014年 duxiaohui. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
            
@property (weak, nonatomic) IBOutlet PlayingCardView *PlayingCardView;
@property (strong, nonatomic)Deck *deck;

@end

@implementation ViewController

-(Deck *)deck
{
    if (!_deck)  _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

-(void)drawRandomPlayingCard
{
    Card *card = [self.deck drawRandomCard];
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        self.PlayingCardView.rank = playingCard.rank;
        self.PlayingCardView.suit = playingCard.suit;
    }
    
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
    if (!self.PlayingCardView.faceUp)
        [self drawRandomPlayingCard];
    
    self.PlayingCardView.faceUp = !self.PlayingCardView.faceUp;
}
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.PlayingCardView.rank = 13;
    self.PlayingCardView.suit = @"♠︎";

    [self.PlayingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.PlayingCardView action:@selector(pinch:)]];
    
}



@end
