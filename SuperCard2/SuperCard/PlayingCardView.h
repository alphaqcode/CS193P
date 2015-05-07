//
//  PlayingCardView.h
//  SuperCard
//
//  Created by duxiaohui on 14-9-25.
//  Copyright (c) 2014年 duxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong,nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
