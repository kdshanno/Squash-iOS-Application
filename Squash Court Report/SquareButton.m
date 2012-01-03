//
//  SquareButton.m
//  Squash Court Report
//
//  Created by Max Shaw on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SquareButton.h"

@implementation SquareButton

@synthesize highLightColor = _highLightColor;

- (void)setUp {
    self.titleLabel.textColor = [UIColor redColor];
    self.highLightColor = [UIColor redColor];
    [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected|UIControlStateHighlighted)];

    self.titleLabel.textAlignment = UITextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.titleLabel setMinimumFontSize:14];
    [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
    self.backgroundColor = [UIColor clearColor];

}

- (void)awakeFromNib {
    [self setUp];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setHighLightColor:(UIColor *)highLightColor {
    _highLightColor = highLightColor;
    [self setTitleColor:highLightColor forState:(UIControlStateNormal)];
}

#define PSIZE 4

void drawDiagonalLine (void *info, CGContextRef context) {
    
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, PSIZE, PSIZE);
    CGContextStrokePath(context);
    
}

void MyStencilPatternPainting (CGContextRef myContext,
                               CGRect windowRect, UIColor *c)
{
    CGPatternRef pattern;
    CGColorSpaceRef baseSpace;
    CGColorSpaceRef patternSpace;

    const CGFloat *color = CGColorGetComponents(c.CGColor);// 1
    static const CGPatternCallbacks callbacks = {0, &drawDiagonalLine, NULL};// 2
    
    baseSpace = CGColorSpaceCreateDeviceRGB ();// 3
    patternSpace = CGColorSpaceCreatePattern (baseSpace);// 4
    CGContextSetFillColorSpace (myContext, patternSpace);// 5
    CGColorSpaceRelease (patternSpace);
    CGColorSpaceRelease (baseSpace);
    pattern = CGPatternCreate(NULL, CGRectMake(0, 0, PSIZE, PSIZE),// 6
                              CGAffineTransformIdentity, PSIZE, PSIZE,
                              kCGPatternTilingConstantSpacing,
                              false, &callbacks);
    CGContextSetFillPattern (myContext, pattern, color);// 7
    CGPatternRelease (pattern);// 8
    CGContextFillRect (myContext, windowRect);// 9
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (self.highlighted || self.selected) {
        CGContextSetFillColorWithColor(context, self.highLightColor.CGColor);
        CGContextSetStrokeColorWithColor(context, self.highLightColor.CGColor);
        MyStencilPatternPainting(context, rect, self.highLightColor);
        UIColor *color = [self.highLightColor colorWithAlphaComponent:0.5];
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);

    }
}

@end
