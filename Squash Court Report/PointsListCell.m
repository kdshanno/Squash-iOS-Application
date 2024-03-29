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
        pointNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 25, height)];
        [pointNumberLabel setTextAlignment:UITextAlignmentRight];
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


- (void)setContentWithRally:(Rally *)r inMatch:(Match *)m
{
    [pointNumberLabel setText:[NSString stringWithFormat:@"%d)", [r.pointNumber intValue]]];
    Player *finishingPlayer;
    if([r.p1Finished boolValue])
        finishingPlayer = m.player1;
    else
        finishingPlayer = m.player2;
    
    NSString *name = [finishingPlayer getName:kFirstInitialLastInitial];

    [playerLabel setText:name];
    [outcomeLabel setText:[ShotFilter stringForShotType:[r.finishingShot intValue]]];
    [locationLabel setText:[r courtAreaString]];
    //[locationLabel setText:[self relativeLocationForX:[r.xPosition doubleValue] andY:[r.yPosition doubleValue]]];
    
    UIColor *color = [ShotFilter colorForShotType:[r.finishingShot intValue]];
    [pointNumberLabel setTextColor:color];
    [playerLabel setTextColor:color];
    [outcomeLabel setTextColor:color];
    [locationLabel setTextColor:color];
    
    
}

                           
                        
@end
