//
//  PointsListCell.m
//  Squash Court Report
//
//  Created by Rishi on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PointsListCell.h"
#import "Player.h"
#import "ShotFilter.h"

@implementation PointsListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        int height = self.frame.size.height;
        //int width = self.frame.size.width;
        
        // Initialization code
        pointNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 25, height)];
        [pointNumberLabel setBackgroundColor:[UIColor clearColor]];
        
        playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 55, height)];
        [playerLabel setBackgroundColor:[UIColor clearColor]];

        outcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 0, 80, height)];
        [outcomeLabel setBackgroundColor:[UIColor clearColor]];

        locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 0, 120, height)];
        [locationLabel setBackgroundColor:[UIColor clearColor]];

        [self.contentView addSubview:pointNumberLabel];
        [self.contentView addSubview:playerLabel];
        [self.contentView addSubview:outcomeLabel];
        [self.contentView addSubview:locationLabel];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/*
- (void)layoutSubviews
{
    [super layoutSubviews];
}*/


- (void)setContentWithRally:(Rally *)r
{
    [pointNumberLabel setText:[NSString stringWithFormat:@"%d)", [r.pointNumber intValue]]];
    [playerLabel setText:@"W.W."];
    //[playerLabel setText:[r.player getName:kFirstInitialLastInitial]];
    [outcomeLabel setText:[ShotFilter stringForShotType:[r.finishingShot intValue]]];
    [locationLabel setText:[self locationForX:[r.xPosition doubleValue] andY:[r.yPosition doubleValue]]];
    
    UIColor *color = [ShotFilter colorForShotType:[r.finishingShot intValue]];
    [pointNumberLabel setTextColor:color];
    [playerLabel setTextColor:color];
    [outcomeLabel setTextColor:color];
    [locationLabel setTextColor:color];
    
    
}

- (NSString *)locationForX:(double)x andY:(double)y
{
    NSString *xPos;
    if(x < 0.5)
        xPos = @"Left";
    else
        xPos = @"Right";
    
    NSString *yPos;
    if(y < 1.0/3.0)
        yPos = @"Front";
    else if (y > 2.0/3.0)
        yPos = @"Back";
    else
        yPos = @"Mid";
    
   // if([xPos compare:yPos] == NSOrderedSame)
   //     return @"Center";
   // else
        return [NSString stringWithFormat:@"%@-%@", yPos, xPos];
}
                           
                        
@end
