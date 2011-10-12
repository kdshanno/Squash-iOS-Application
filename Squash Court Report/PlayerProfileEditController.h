//
//  PlayerProfileController.h
//  Squash Court Report
//
//  Created by Max Shaw on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataModel.h"
#import "TextFieldCell.h"

@protocol PlayerEditDelegate <NSObject>

- (void)didChangeData;

@end

@interface PlayerProfileEditController : UITableViewController

@property (strong, nonatomic) Player *player;

@property (strong, nonatomic) UITextField *firstNameField;
@property (strong, nonatomic) UITextField *lastNameField;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (retain) id delegate;


@end
