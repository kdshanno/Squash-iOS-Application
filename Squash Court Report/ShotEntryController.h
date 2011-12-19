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

@interface ShotEntryController : UIViewController {
    CGRect entryViewFrameUp;
    CGRect entryViewFrameDown;
    CGRect imageFrameBig;
    CGRect imageFrameSmall;
    bool entryViewUp;

}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Match *match;
@property (strong, nonatomic) IBOutlet UIImageView *courtImage;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *titleButton;
@property (strong, nonatomic) IBOutlet UIView *entryView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *playerSegmentedControl;
@property (strong, nonatomic) IBOutlet UIScrollView *entryScrollView;
@property (strong, nonatomic) IBOutlet UILabel *p1NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *p2NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *p1ScoreNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *p2ScoreNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *p1ScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *p2ScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *gameNumberLabel;
@property (strong, nonatomic) IBOutlet UIStepper *p1Stepper;
@property (strong, nonatomic) IBOutlet UIStepper *p2Stepper;
@property (strong, nonatomic) IBOutlet UIStepper *gameStepper;



-(IBAction)animateImage:(id)sender;
-(IBAction)playerScoreChanged:(id)sender;
-(IBAction)gameNumberChanged:(id)sender;
- (void)courtTapped:(UIGestureRecognizer *)sender;
- (void)doneButtonPressed;

@end
