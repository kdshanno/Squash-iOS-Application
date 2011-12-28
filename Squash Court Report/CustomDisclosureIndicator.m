//
//  CustomDisclosureIndicator.m
//  Squash Court Report
//
//  Created by Max Shaw on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomDisclosureIndicator.h"

@implementation CustomDisclosureIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor  = [UIColor clearColor];
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 3.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    
    CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
    
    CGContextMoveToPoint(context, 3, 3);
    CGContextAddLineToPoint(context, self.bounds.size.width-3, self.bounds.size.height/2.0);
    CGContextAddLineToPoint(context, 3, self.bounds.size.height-3);
    
    CGContextStrokePath(context);
    
    CGColorSpaceRelease(colorspace);

}


@end
