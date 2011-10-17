//
//  ShotEntryController.h
//  Squash Court Report
//
//  Created by Maxwell Shaw on 10/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataModel.h"
#import <QuartzCore/QuartzCore.h>

@interface ShotEntryController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Match *match;
@property (strong, nonatomic) IBOutlet UIImageView *courtImage;

-(IBAction)animateImage:(id)sender;

@end
