//
//  StatsHeaderView.m
//  Squash Court Report
//
//  Created by Max Shaw on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StatsHeaderView.h"
#import "Match.h"
#import "Player.h"
#import "SquareButton.h"

@implementation StatsHeaderView

- (id)initWithFrame:(CGRect)frame andMatch:(Match *)match
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *stats = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, frame.size.height)];
        stats.text = @"Stats";
        stats.textAlignment = UITextAlignmentCenter;
        stats.textColor = [UIColor redColor];
        stats.font = [UIFont boldSystemFontOfSize:20];
        stats.backgroundColor = [UIColor clearColor];
        
        UIButton *buttonCenter = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonCenter.frame = CGRectMake(120, 0, 100, frame.size.height);
        [buttonCenter setTitle:[match.player1 getName:kFirstInitialLastName] forState:UIControlStateNormal];
        buttonCenter.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [buttonCenter.titleLabel setMinimumFontSize:15];
        [buttonCenter.titleLabel setAdjustsFontSizeToFitWidth:YES];
        buttonCenter.titleLabel.textColor = [UIColor redColor];
        buttonCenter.backgroundColor = [UIColor clearColor];
        
        UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonRight.frame = CGRectMake(220, 0, 100, frame.size.height);
        [buttonRight setTitle:[match.player2 getName:kFirstInitialLastName] forState:UIControlStateNormal];
        buttonRight.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [buttonRight.titleLabel setMinimumFontSize:15];
        buttonRight.titleLabel.textColor = [UIColor redColor];
        [buttonRight.titleLabel setAdjustsFontSizeToFitWidth:YES];
        buttonRight.backgroundColor = [UIColor clearColor];

            
        [self addSubview:stats];
        [self addSubview:buttonCenter];
        [self addSubview:buttonRight];
        
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);

    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    
    
    CGContextStrokeRect(context, rect);
    
    
//    CGContextMoveToPoint(context, 0, rect.size.height);
//    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    
    CGContextMoveToPoint(context, 120, 0);
    CGContextAddLineToPoint(context, 120, rect.size.height);
    
    CGContextMoveToPoint(context, 220, 0);
    CGContextAddLineToPoint(context, 220, rect.size.height);
    
    CGContextStrokePath(context);



}


@end
