//
//  PointsListViewController.h
//  Squash Court Report
//
//  Created by Rishi on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShotFilter.h"
#import "Match.h"
#import "Game.h"

/**
 
 
 
 Add animation for expanding and collapsing.
 
 
 
 */
@interface PointsListViewController : UITableViewController
{
    Match *match;
    ShotFilter *filter;
    NSMutableArray *games;
    NSMutableArray *pointArrays;
    BOOL expandedGames[5];
}

/* If match == nil, error(); filter == nil, then show all shots */
- (PointsListViewController *)initWithMatch:(Match *)match andFilter:(ShotFilter *)filter;
- (void)expandCollapse:(id)b;

@end
