//
//  MatchListViewController.h
//  Squash Court Report
//
//  Created by Rishi on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface MatchListController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Player *player;
    NSFetchedResultsController *fetchedResults;
}

@property(nonatomic, retain) Player *player;

/* Only one of the following two init methods should be called. */
-(MatchListController *)initWithPlayer:(Player *)player;
-(MatchListController *)initForAllMatches; 

-(NSString *)dateToString:(NSDate *)date;

@end
