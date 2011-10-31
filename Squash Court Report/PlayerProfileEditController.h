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

@protocol PlayerProfileEditDelegate <NSObject>

- (void)didChangeData;

@end

@interface PlayerProfileEditController : UITableViewController <UITextFieldDelegate> {
    UITextField *firstNameField;
    UITextField *lastNameField;
    UITextField *playerStyle;
    UITextField *city;
    UITextField *stateProvince;
    UITextField *country;
    UITextField *homeClub;
    UITextField *headCoach;
    
    UISegmentedControl *handednessSegControl;
    
    NSMutableDictionary *cellDictionary;
}

@property (strong, nonatomic) Player *player;




@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (retain) id delegate;

- (id)initWithStyle:(UITableViewStyle)style andPlayer:(Player *)editingPlayer;


@end
