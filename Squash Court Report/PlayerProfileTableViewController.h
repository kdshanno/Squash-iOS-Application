//
//  PlayerProfileTableViewController.h
//  Squash Court Report
//
//  Created by Maxwell Shaw on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataModel.h"
#import <CoreData/CoreData.h>
#import "PlayerProfileEditController.h"
#import "PlayerEditController.h"
#import "SectionHeaderView.h"



@interface PlayerProfileTableViewController : UITableViewController <PlayerEditDelegate, SectionHeaderDelegate> {
    Player *player;
    NSMutableArray *bioLeftLabels;
    NSMutableArray *bioRightLabels;
    NSMutableArray *statsLeftLabels;
    NSMutableArray *statsRightLabels;
    NSMutableArray *recentMatchesLeftLabels;
    NSMutableArray *recentMatchesRightLabels;
    NSMutableArray *sectionCollapse;
    
    NSArray *recentMatches;
}

@property (strong, nonatomic) Player *player;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UIView *sectionHeaderView;

- (id)initWithStyle:(UITableViewStyle)style andPlayer:(Player *)newPlayer;


@end
