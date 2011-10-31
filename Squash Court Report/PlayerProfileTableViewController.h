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


@interface PlayerProfileTableViewController : UITableViewController <PlayerEditDelegate> {
    Player *player;
    NSMutableArray *bioLeftLabels;
    NSMutableArray *bioRightLabels;
    NSMutableArray *statsLeftLabels;
    NSMutableArray *statsRightLabels;
}

@property (strong, nonatomic) Player *player;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UIView *sectionHeaderView;

- (id)initWithStyle:(UITableViewStyle)style andPlayer:(Player *)newPlayer;


@end
