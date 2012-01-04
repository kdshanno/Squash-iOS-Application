//
//  LegendView.m
//  Squash Court Report
//
//  Created by Max Shaw on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LegendView.h"

@implementation LegendView

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIColor *tan = [UIColor colorWithRed:254.0/255.0 green:241.0/255.0 blue:183.0/255.0 alpha:1.0];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect legendRect = CGRectMake(20, 20, 280, 340);
    
    CGContextSetFillColorWithColor(context, tan.CGColor);
    CGContextFillRect(context, legendRect);

    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 4.0);
    CGContextStrokeRect(context, legendRect);
    
    
}


@end
