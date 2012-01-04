//
//  LegendsCell.m
//  Squash Court Report
//
//  Created by Max Shaw on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LegendsCell.h"
#import "ShotFilter.h"

@implementation LegendsCell

@synthesize legendKeyLabel;
@synthesize finishingShot = _finishingShot;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        legendKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 90, self.frame.size.height)];
        legendKeyLabel.font = [UIFont boldSystemFontOfSize:14];
        legendKeyLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:legendKeyLabel];
        
        [self setBackgroundColor:[UIColor clearColor]];
        // Initialization code
    }
    return self;
}

- (void)setFinishingShot:(ender)finishingShot {
    _finishingShot = finishingShot;
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    double width = 10;
    double height = 10;
    
    CGContextSetFillColorWithColor(context, [[ShotFilter colorForShotType:self.finishingShot] colorWithAlphaComponent:1.0].CGColor);

    
    float x = 160;
    float y = rect.size.height/2.0;
    CGRect circle = CGRectMake(x-width/2.0, y-height/2.0, width, height);
    CGContextFillEllipseInRect(context, circle);
    
    x = 260;
    CGRect square = CGRectMake(x-width/2.0, y-height/2.0, width, height);
    CGContextFillRect(context, square);

}

@end
