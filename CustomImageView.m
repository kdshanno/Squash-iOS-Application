//
//  CustomImageView.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

-(void)touchDown:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        drawGuides = TRUE;
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        drawGuides = FALSE;
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        drawGuides = FALSE;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchDown:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
    
    CGColorRef color = CGColorCreate(colorspace, components);
    
    CGContextSetStrokeColorWithColor(context, color);
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 300, 400);
    
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 0, self.bounds.size.width);
    
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
}


@end
