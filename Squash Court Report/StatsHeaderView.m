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

@synthesize leftHeaderView, centerTopView, centerBottomView, rightTopView, rightBottomView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        leftHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, frame.size.height)];
        
        centerTopView = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 100, frame.size.height/2)];
        
        centerBottomView = [[UILabel alloc] initWithFrame:CGRectMake(120, frame.size.height/2, 100, frame.size.height/2)];
        
        rightTopView = [[UILabel alloc] initWithFrame:CGRectMake(220, 0, 100, frame.size.height/2)];
        
        rightBottomView = [[UILabel alloc] initWithFrame:CGRectMake(220, frame.size.height/2, 100, frame.size.height/2)];
             
        NSArray *labels = [NSArray arrayWithObjects:leftHeaderView, centerTopView, centerBottomView, rightTopView, rightBottomView, nil];
        
        for (UILabel *label in labels) {
            label.textAlignment = UITextAlignmentCenter;
            label.textColor = [UIColor redColor];
            label.font = [UIFont boldSystemFontOfSize:14];
            label.backgroundColor = [UIColor clearColor];
            [self addSubview:label];
        }
        
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
    
    CGContextMoveToPoint(context, 0, rect.size.height-1);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-1);
    CGContextStrokePath(context);
    
//    CGContextStrokeRect(context, rect);
    
    
//    CGContextMoveToPoint(context, 0, rect.size.height);
//    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    
//    CGContextMoveToPoint(context, 120, 0);
//    CGContextAddLineToPoint(context, 120, rect.size.height);
//    
//    CGContextMoveToPoint(context, 220, 0);
//    CGContextAddLineToPoint(context, 220, rect.size.height);
//    
//    CGContextStrokePath(context);



}


@end
