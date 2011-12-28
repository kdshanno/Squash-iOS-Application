//
//  CustumImageView.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CourtView.h"

@implementation CourtView

@synthesize drawDot;
@synthesize drawGuides = _drawGuides;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      //  [self setAutoresizesSubviews:YES];
    //    [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        x = 0;
        y = 0;
        self.drawDot = NO;
        self.backgroundColor = [UIColor blackColor];
        
        self.drawGuides = FALSE;

    }
    return self;
}
/*
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}*/

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIImage *tempImage = [UIImage imageNamed:@"Default.png"];
    [tempImage drawInRect:CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height)];
    // Drawing code
    

    if (self.drawDot) {
//        float width = self.bounds.size.width;
//        float height = self.bounds.size.height;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetLineWidth(context, 2.0);
        
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        
        CGFloat components[] = {0.0, 0.0, 0.0, 1.0};
        
        CGColorRef color = CGColorCreate(colorspace, components);
        
        CGContextSetStrokeColorWithColor(context, color);
        CGContextSetFillColorWithColor(context, color);
        
        double width = 10;
        double height = 10;
        CGRect square = CGRectMake(self.bounds.size.width*x-width/2.0, self.bounds.size.height*y-height/2.0, 10, 10);
        CGContextFillEllipseInRect(context, square);
        
        if (self.drawGuides) {
            CGContextMoveToPoint(context, 0, y*self.bounds.size.height);
            CGContextAddLineToPoint(context, self.bounds.size.width, y*self.bounds.size.height);
            CGContextStrokePath(context);
            
            CGContextMoveToPoint(context, x*self.bounds.size.width, 0);
            CGContextAddLineToPoint(context, x*self.bounds.size.width, self.bounds.size.height);
            CGContextStrokePath(context);
        }
        

        
        CGColorSpaceRelease(colorspace);
        CGColorRelease(color);

    }
    
    
}

-(void)setX:(double)xNew andY:(double)yNew {
    x = xNew;
    y = yNew;
    self.drawDot = YES;
   [self setNeedsDisplay];
}

-(void)removeDot {
    self.drawDot = NO;
    [self setNeedsDisplay];
}




@end
