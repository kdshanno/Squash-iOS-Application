//
//  MatchSetupViewController.h
//  Squash Court Report
//
//  Created by Rishi Narang on 10/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "AnimatedUIPickerView.h"

@interface MatchSetupViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property(strong, nonatomic) IBOutlet UILabel *player1Label;
@property(strong, nonatomic) IBOutlet UILabel *player2Label;
@property(strong, nonatomic) IBOutlet UIButton *selectionButton;
@property(strong, nonatomic) IBOutlet UIButton *matchProfileButton;
@property(strong, nonatomic) AnimatedUIPickerView *picker;

@property(assign, nonatomic) int player1Index; //-1 if no player has been selected
@property(assign, nonatomic) int player2Index; //-1 if no player has been selected
@property(assign, nonatomic) int playerBeingEdited; //1 if a new player 1 is being created, 2 if a new player 2 is being created, else 0
@property(strong, nonatomic) NSMutableArray *players;

-(IBAction)player1Dropdown;
-(IBAction)player2Dropdown;
-(IBAction)newPlayer1;
-(IBAction)newPlayer2;
-(IBAction)finishSelection;
-(IBAction)setupMatchProfile;

@end
