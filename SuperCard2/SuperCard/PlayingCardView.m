//
//  PlayingCardView.m
//  SuperCard
//
//  Created by duxiaohui on 14-9-25.
//  Copyright (c) 2014年 duxiaohui. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

#pragma mark - Properties

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.85

-(CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

-(void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}


-(void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

-(void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}
-(void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

-(void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1.0;
    }
}


#pragma mark - Drawing


#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

-(CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
-(CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
-(CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }
//-(CGFloat)pipsOffset { return [self cornerRadius];}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius: [self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    
    if (self.faceUp) {
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",[self rankAsString],self.suit]];
        if (faceImage) {
            //
            CGRect imageRect = CGRectInset(self.bounds,
                                           self.bounds.size.width * (1.0-self.faceCardScaleFactor),
                                           self.bounds.size.height * (1.0-self.faceCardScaleFactor));
            [faceImage drawInRect:imageRect];
        } else {
            //draw
            [self drawPips];
        }
        
        [self drawCorners];
    } else {
        [[UIImage imageNamed:@"cardBack"] drawInRect:self.bounds];
    }
    
}

#pragma mark - Pips

#define PIP_VOFFSET_PERCETAGE 0.165
#define PIP_VOFFSET1_PERCETAGE 0.090
#define PIP_VOFFSET2_PERCETAGE 0.175
#define PIP_VOFFSET3_PERCETAGE 0.270

-(void)drawPips
{
    //中心一个
    if ((self.rank == 1) || (self.rank == 3) || (self.rank == 5) || (self.rank == 9)) {
        [self drawPipsWithhorizontalOffset:0
                            verticaloffset:0
                        mirroredVertically:NO];
    }
    //中间两个
    if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8) ) {
        [self drawPipsWithhorizontalOffset:PIP_VOFFSET_PERCETAGE
                            verticaloffset:0
                        mirroredVertically:NO];
    }
    //中心两个
    if ((self.rank == 2) || (self.rank == 3) || (self.rank == 10) || (self.rank == 7) || (self.rank == 8) ) {
        [self drawPipsWithhorizontalOffset:0
                            verticaloffset:PIP_VOFFSET2_PERCETAGE
                        mirroredVertically:(self.rank != 7)];
    }
    //边角4个
    if ((self.rank == 4) || (self.rank == 5) || (self.rank == 6) || (self.rank == 7) || (self.rank == 8) || (self.rank == 9) || (self.rank == 10) ) {
        [self drawPipsWithhorizontalOffset:PIP_VOFFSET_PERCETAGE
                            verticaloffset:PIP_VOFFSET3_PERCETAGE
                        mirroredVertically:YES];
    }
    //中间两行
    if ((self.rank == 9) || (self.rank == 10) ) {
        [self drawPipsWithhorizontalOffset:PIP_VOFFSET_PERCETAGE
                            verticaloffset:PIP_VOFFSET1_PERCETAGE
                        mirroredVertically:YES];
    }
}

#define PIP_FONT_SCALE_FACTOR 0.012

-(void)drawPipsWithhorizontalOffset:(CGFloat)hoffset
                     verticaloffset:(CGFloat)voffset
                         upsideDown:(BOOL)upsideDown
{
    if (upsideDown) [self pushContextAndRotateUpsideDown];
    
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    UIFont *pipsFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    pipsFont = [pipsFont fontWithSize:[pipsFont pointSize]*self.bounds.size.width*PIP_FONT_SCALE_FACTOR];
    
    NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit
                                                                         attributes:@{NSFontAttributeName:pipsFont}];
    CGSize pipSize = attributedSuit.size;
    CGPoint pipOrigin = CGPointMake(middle.x-pipSize.width/2-hoffset*self.bounds.size.width,
                                    middle.y-pipSize.height/2-voffset*self.bounds.size.height);
    [attributedSuit drawAtPoint:pipOrigin];
    if (hoffset) {
        pipOrigin.x += hoffset*2.0*self.bounds.size.width;
        [attributedSuit drawAtPoint:pipOrigin];
    }
    if (upsideDown) [self popContext];
}



-(void)drawPipsWithhorizontalOffset:(CGFloat)hoffset
                     verticaloffset:(CGFloat)voffset
                 mirroredVertically:(BOOL)mirroredVertically
{
    [self drawPipsWithhorizontalOffset:hoffset verticaloffset:voffset upsideDown:NO];
    if (mirroredVertically) {
        [self drawPipsWithhorizontalOffset:hoffset verticaloffset:voffset upsideDown:YES];
    }
}

-(void)pushContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

-(void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}


-(NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

-(void) drawCorners
{
    //段落类型，居中
    NSMutableParagraphStyle *paragraghStyle = [[NSMutableParagraphStyle alloc] init];
    paragraghStyle.alignment = NSTextAlignmentCenter;
    //字体
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    
    //牌面text
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[self rankAsString],self.suit] attributes:@{NSFontAttributeName: cornerFont,NSParagraphStyleAttributeName: paragraghStyle}];
    
    //CGRect
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset],[self cornerOffset]);
    textBounds.size = cornerText.size;
    
    [cornerText drawInRect:textBounds];
    
    
    //对角线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    
    [cornerText drawInRect:textBounds];
    
    
}
//    //段落
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//
//    //字体
//    UIFont *pipsFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
//    pipsFont = [pipsFont fontWithSize:pipsFont.pointSize * [self cornerScaleFactor] * 2];
//
//    //suit
//    NSAttributedString *pipsText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.suit]
//                                                                                                  attributes:@{NSFontAttributeName:pipsFont,NSParagraphStyleAttributeName:paragraphStyle}];
//    //CGRect
//    CGRect pipsBounds;
//    pipsBounds.origin = CGPointMake((self.bounds.size.width - pipsText.size.width)/2,
//                                    (self.bounds.size.height - pipsText.size.height)/2 );
//    pipsBounds.size = pipsText.size;
//
//    [pipsText drawInRect:pipsBounds];

//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(context, (self.bounds.size.width + pipsText.size.width)/2, (self.bounds.size.height + pipsText.size.height)/2 );
//
//    [pipsText drawInRect:pipsBounds];
//    UIBezierPath *path = [[UIBezierPath alloc]init];
//    [path moveToPoint:CGPointMake(90, 40)];
//    [path addLineToPoint:CGPointMake(130, 100)];
//    [path addLineToPoint:CGPointMake(50, 100)];
//    [path closePath];
//
//    [[UIColor greenColor] setFill];
//    [[UIColor redColor] setStroke];
//    [path fill];
//    [path stroke];


#pragma mark - initalization

-(void) setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    //self.alpha = 0.5;
    self.contentMode = UIViewContentModeRedraw;
}

-(void)awakeFromNib
{
    [self setup];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
