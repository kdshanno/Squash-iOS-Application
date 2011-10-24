//
//  MatchProfileViewController.h
//  Squash Court Report
//
//  Created by Rishi Narang on 10/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Match.h"
#import "Player.h"

@interface MatchProfileViewController : UIViewController


@property(strong, nonatomic) IBOutlet UILabel *player1Label;
@property(strong, nonatomic) IBOutlet UILabel *player2Label;
@property(strong, nonatomic) IBOutlet UISegmentedControl *tournamentMatchSwitch;
@property(strong, nonatomic) IBOutlet UISegmentedControl *gameTypeSwitch;
@property(strong, nonatomic) IBOutlet UILabel *dateLabel;
@property(strong, nonatomic) IBOutlet UITextField *buildingField;
@property(strong, nonatomic) IBOutlet UITextField *cityField;
@property(strong, nonatomic) IBOutlet UITextField *stateField;
@property(strong, nonatomic) IBOutlet UITextField *countryField;
@property(strong, nonatomic) IBOutlet UITextField *conditionField;
@property(strong, nonatomic) IBOutlet UITextField *tournamentNameField;
@property(strong, nonatomic) IBOutlet UITextField *roundField;
@property(strong, nonatomic) IBOutlet UITextView *notesTextView;

@property(strong, nonatomic) Match *match;
@property(strong, nonatomic) Player *p1;
@property(strong, nonatomic) Player *p2;



- (IBAction)dateButtonPressed;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil player1:(Player *)player1 player2:(Player *)player2;




@end
