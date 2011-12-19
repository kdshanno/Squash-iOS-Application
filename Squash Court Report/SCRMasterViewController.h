//
//  SCRMasterViewController.h
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCRDetailViewController;

#import <CoreData/CoreData.h>

@interface SCRMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) SCRDetailViewController *detailViewController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;



@end
