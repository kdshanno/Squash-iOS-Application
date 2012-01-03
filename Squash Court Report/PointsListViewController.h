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

@interface PointsListViewController : UITableViewController
{
    Match *match;
    ShotFilter *filters[2];
    NSMutableArray *games;
    NSMutableArray *pointArrays;
    BOOL expandedGames[5];
}

/* If match == nil, error(); if filters[i] == nil, then show all shots for that player */
- (PointsListViewController *)initWithMatch:(Match *)match andPlayerOneFilter:(ShotFilter *)filterOne andPlayerTwoFilter:(ShotFilter *)filterTwo;

/* Switch between expanded and collapsed for a given section */
- (void)expandCollapse:(id)b;

/* Given an array of points, return an array of those points that are not filtered out by the filters. */
- (NSMutableArray *)filterOutPoints:(NSMutableArray *)points;

/* Is this point a valid point among the filters? */
- (BOOL)keepPoint:(Rally *)rally;

@end
