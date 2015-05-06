//
//  TextStatsViewController.m
//  Attributor
//
//  Created by duxiaohui on 14-9-15.
//  Copyright (c) 2014年 duxiaohui. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharacters;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharacters;

@end

@implementation TextStatsViewController

-(void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)updateUI
{
    self.colorfulCharacters.text = [NSString stringWithFormat:@"%lu colorful characters",(unsigned long)[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharacters.text = [NSString stringWithFormat:@"%d outlined characters",(int)[[self charactersWithAttribute:NSStrokeWidthAttributeName] length] ];
    
}




- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName;
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]){
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = (int)(range.location + range.length);
        }
        else {
            index ++;
        }
    }
    
    return characters;
}

@end

