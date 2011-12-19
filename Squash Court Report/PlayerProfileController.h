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
#import "PlayerEditController.h"

@interface PlayerProfileController : UIViewController <PlayerEditDelegate> {
    Player *player;
}

@property (strong, nonatomic) Player *player;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *playerPicture;
@property (strong, nonatomic) IBOutlet UILabel *recordLabel;
@property (strong, nonatomic) IBOutlet UILabel *winnersLabel;
@property (strong, nonatomic) IBOutlet UILabel *errorsLabel;
@property (strong, nonatomic) IBOutlet UILabel *letsLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastgame1label;
@property (strong, nonatomic) IBOutlet UILabel *lastgame1date;
@property (strong, nonatomic) IBOutlet UILabel *lastgame2label;
@property (strong, nonatomic) IBOutlet UILabel *lastgame2date;
@property (strong, nonatomic) IBOutlet UILabel *lastgame3label;
@property (strong, nonatomic) IBOutlet UILabel *lastgame3date;




@end
