//
//  PlayerProfileController.h
//  Squash Court Report
//
//  Created by Max Shaw on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataModel.h"
#import <CoreData/CoreData.h>
#import "PlayerProfileEditController.h"


@interface PlayerProfileController : UITableViewController <PlayerEditDelegate>

@property (strong, nonatomic) Player *player;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
