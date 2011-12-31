//
//  MatchListViewController.h
//  Squash Court Report
//
//  Created by Rishi on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface MatchListViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    Player *player;
    NSFetchedResultsController *fetchedResults;
}

@property(nonatomic, retain) Player *player;

/* Only one of the following two init methods should be called. */
-(MatchListViewController *)initWithPlayer:(Player *)player;
-(MatchListViewController *)initForAllMatches; 

@end
