//
//  PointsCourtVie.m
//  Squash Court Report
//
//  Created by Max Shaw on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PointsCourtView.h"
#import "CoreDataModel.h"
#import "ShotFilter.h"

@implementation PointsCourtView

@synthesize p1RallyArray = _p1RallyArray;
@synthesize p2RallyArray = _p2RallyArray;
@synthesize scale = _scale;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setScale:(float)scale {
    _scale = scale;
    [self setNeedsDisplay];
}
-(void)setP1RallyArray:(NSArray *)p1RallyArray {
    _p1RallyArray = p1RallyArray;
    [self setNeedsDisplay];
}

-(void)setP2RallyArray:(NSArray *)p2RallyArray {
    _p2RallyArray = p2RallyArray;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIImage *tempImage = [UIImage imageNamed:@"Default.png"];
    [tempImage drawInRect:CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height)];

    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    double width = 10;
    double height = 10;

    for (Rally *rally in self.p1RallyArray) {
        CGContextSetFillColorWithColor(context, [[ShotFilter colorForShotType:rally.finishingShot.intValue] colorWithAlphaComponent:1.0].CGColor);
        float x = rally.xPosition.floatValue;
        float y = rally.yPosition.floatValue;
        CGRect square = CGRectMake(self.bounds.size.width*x-width/2.0, self.bounds.size.height*y-height/2.0, width, height);
        CGContextFillEllipseInRect(context, square);
    }
    
    for (Rally *rally in self.p2RallyArray) {
        CGContextSetFillColorWithColor(context, [[ShotFilter colorForShotType:rally.finishingShot.intValue] colorWithAlphaComponent:1.0].CGColor);
        float x = rally.xPosition.floatValue;
        float y = rally.yPosition.floatValue;
        CGRect square = CGRectMake(self.bounds.size.width*x-width/2.0, self.bounds.size.height*y-height/2.0, width, height);
        CGContextFillRect(context, square);
    }

    
}


@end
