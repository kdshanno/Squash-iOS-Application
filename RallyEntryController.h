//
//  RallyEntryController.h
//  Squash Court Report
//
//  Created by Max Shaw on 10/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataModel.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreData/CoreData.h>
#import "CourtView.h"

@protocol rallyEntryDelegate <NSObject>

-(void)popToMatchOverview:(Match *)match;

@end

@interface RallyEntryController : UIViewController <UIScrollViewDelegate, UIPageViewControllerDelegate, UIActionSheetDelegate> {
    int gameNumber;
    int p1Score;
    int p2Score;
    CGRect entryViewFrameUp;
    CGRect entryViewFrameDown;
    CGRect imageFrameBig;
    CGRect imageFrameSmallTemp;

    CGRect imageFrameSmall;
    bool entryViewUp;
    UIBarButtonItem *doneButton;
    UIBarButtonItem *leftTopButton;
    UIBarButtonItem *rightTopButton;
    UIBarButtonItem *topTitle;
    Rally *currentRally;
    Game *currentGame;
    double xVal;
    double yVal;
    id delegate;
    
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Match *match;
@property (strong, nonatomic) IBOutlet UIImageView *courtImage;
@property (strong, nonatomic) CourtView *courtView;
@property (strong, nonatomic) IBOutlet UIToolbar *bottomToolbar;
@property (strong, nonatomic) IBOutlet UIToolbar *topToolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *titleButton;
@property (strong, nonatomic) IBOutlet UIView *opaqueView;
@property (strong, nonatomic) IBOutlet UIView *entryView;
@property (strong, nonatomic) IBOutlet UIScrollView *entryScrollView;
@property (strong, nonatomic) IBOutlet UILabel *p1NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *p2NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *p1ScoreNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *p2ScoreNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *p1ScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *p2ScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *gameNumberLabel;
@property (strong, nonatomic) UIControl *p1Stepper;
@property (strong, nonatomic) UIControl *p2Stepper;
@property (strong, nonatomic) UIControl *gameStepper;
@property (strong, nonatomic) IBOutlet UISegmentedControl *playerSegControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *shotSegControlTop;
@property (strong, nonatomic) IBOutlet UISegmentedControl *shotSegControlBottom;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *scoreItemButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *previousRallyButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextRallyButton;
@property (strong, nonatomic) IBOutlet UIView *topOverlayView;
@property (strong, nonatomic) IBOutlet UILabel *topOverlayTitle;
@property (strong, nonatomic) IBOutlet UILabel *topOverlaySubtitle;
@property (strong, nonatomic) IBOutlet UILabel *gameWonLabel;
@property (strong, nonatomic) IBOutlet UIButton *rallyDoneButton;
@property (strong, nonatomic) IBOutlet UIButton *rallyWithGameDoneButton;
@property (strong, nonatomic) id delegate;



@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *gameArray;
@property (strong, nonatomic) NSMutableDictionary *gameDic;
@property (strong, nonatomic) NSMutableArray *rallyArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil match:(Match *)currentMatch;
- (id)initWithMatch:(Match *)currentMatch;

-(void)leftButtonPressed:(UIBarButtonItem *)sender;
-(void)rightButtonPressed:(UIBarButtonItem *)sender;
-(void)finishButtonPressed;
-(IBAction)animateImage:(id)sender;
-(IBAction)playerSegChanged:(id)sender;
-(IBAction)topShotSegChanged:(id)sender;
-(IBAction)bottomShotSegChanged:(id)sender;
-(IBAction)playerScoreChanged:(id)sender;
-(IBAction)gameNumberChanged:(id)sender;
- (void)courtTapped:(UIGestureRecognizer *)sender;
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)pageControlChanged:(id)sender;
- (IBAction)rewindButtonPressed:(id)sender;
- (IBAction)fastFowardButtonPressed:(id)sender;
- (IBAction)scoreButtonPressed:(id)sender;
- (IBAction)infoButtonPressed:(id)sender;
- (IBAction)doneWithGameDoneButtonPressed:(id)sender;



@end
