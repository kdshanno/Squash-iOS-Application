//
//  RallyEntryController.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
// Test

#import "RallyEntryController.h"
#import "SCRAppDelegate.h"
#import "SQRStepper.h"
#import "MatchOverviewController.h"

@implementation RallyEntryController

@synthesize managedObjectContext, match, courtImage, bottomToolbar, titleButton, entryView, entryScrollView, p1NameLabel, p1ScoreLabel, p2NameLabel, p2ScoreLabel, gameNumberLabel, p1Stepper, p2Stepper, gameStepper, p1ScoreNameLabel, p2ScoreNameLabel, topToolbar, opaqueView, playerSegControl, shotSegControlTop, shotSegControlBottom, pageControl, scoreItemButton, gameArray, gameDic, rallyArray, courtView, previousRallyButton, nextRallyButton, topOverlayView, topOverlayTitle, topOverlaySubtitle, gameWonLabel, rallyDoneButton, rallyWithGameDoneButton, delegate;

- (void)addSteppers {
    float version = [[UIDevice currentDevice].systemVersion floatValue];
    if (version < 5.0) {
        self.gameStepper = [[SQRStepper alloc] initWithFrame:CGRectMake(524, 61, 94, 27)];
        [(SQRStepper *)self.gameStepper setMinimumValue:0];
        [(SQRStepper *)self.gameStepper setMaximumValue:100];
        [(SQRStepper *)self.gameStepper addTarget:self action:@selector(gameNumberChanged:) forControlEvents:UIControlEventValueChanged];
        [self.entryScrollView addSubview:self.gameStepper];
        
        self.p1Stepper = [[SQRStepper alloc] initWithFrame:CGRectMake(524, 133, 94, 27)];
        [(SQRStepper *)self.p1Stepper setMinimumValue:0];
        [(SQRStepper *)self.p1Stepper setMaximumValue:100];
        [(SQRStepper *)self.p1Stepper addTarget:self action:@selector(playerScoreChanged:) forControlEvents:UIControlEventValueChanged];
        [self.entryScrollView addSubview:self.p1Stepper];


        
        self.p2Stepper = [[SQRStepper alloc] initWithFrame:CGRectMake(524, 171, 94, 27)];
        [(SQRStepper *)self.p2Stepper setMinimumValue:0];
        [(SQRStepper *)self.p2Stepper setMaximumValue:100];
        [(SQRStepper *)self.p2Stepper addTarget:self action:@selector(playerScoreChanged:) forControlEvents:UIControlEventValueChanged];
        [self.entryScrollView addSubview:self.p2Stepper];

    }
    
    else {
        self.gameStepper = [[UIStepper alloc] initWithFrame:CGRectMake(524, 61, 94, 27)];
        [(UIStepper *)self.gameStepper setMinimumValue:0];
        [(UIStepper *)self.gameStepper setMaximumValue:100];
        [(UIStepper *)self.gameStepper addTarget:self action:@selector(gameNumberChanged:) forControlEvents:UIControlEventValueChanged];
        [self.entryScrollView addSubview:self.gameStepper];

        
        self.p1Stepper = [[UIStepper alloc] initWithFrame:CGRectMake(524, 133, 94, 27)];
        [(UIStepper *)self.p1Stepper setMinimumValue:0];
        [(UIStepper *)self.p1Stepper setMaximumValue:100];
        [(UIStepper *)self.p1Stepper addTarget:self action:@selector(playerScoreChanged:) forControlEvents:UIControlEventValueChanged];
        [self.entryScrollView addSubview:self.p1Stepper];

        
        
        self.p2Stepper = [[UIStepper alloc] initWithFrame:CGRectMake(524, 171, 94, 27)];
        [(UIStepper *)self.p2Stepper setMinimumValue:0];
        [(UIStepper *)self.p2Stepper setMaximumValue:100];
        [(UIStepper *)self.p2Stepper addTarget:self action:@selector(playerScoreChanged:) forControlEvents:UIControlEventValueChanged];
        [self.entryScrollView addSubview:self.p2Stepper];

    }

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Match";
                
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil match:(Match *)currentMatch
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.match = currentMatch;
        self.title = @"Match";
    }
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
        self.title = @"Match";
        
    }
    return self;
}

-(id)initWithMatch: (Match *) currentMatch {
    self = [super init];
    if (self) {
        self.title = @"Match";
        self.match = currentMatch;    
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (Rally *)addRallyWithGameNumber:(int)gmNumber andPointNumber:(int)pntNumber {    
    SCRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [appDelegate managedObjectContext];
    
    //Check to see if game exists
    currentGame = [[self.match.games objectsPassingTest:^BOOL(id obj, BOOL *stop) {
        Game *game = (Game *)obj;
        return (game.number.intValue == gmNumber);
    }] anyObject];
    if (!currentGame) {
        currentGame = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:moc];
        currentGame.number = [NSNumber numberWithInt:gmNumber];
        [self.match addGamesObject:currentGame];
    }
    
    currentRally = [NSEntityDescription insertNewObjectForEntityForName:@"Rally" inManagedObjectContext:moc];
    [currentGame addRalliesObject:currentRally];
    //currentRally.pointNumber = [NSNumber numberWithInt:pntNumber];
    
    
    //Check to see if rally exists
    //Add Rally to Rally Array
    [self.rallyArray addObject:currentRally];
    return currentRally;
    
}

//Find Previous Rally
- (Rally *)previousRally {
    int currentRallyNumber;
    if (!currentRally) {
        currentRallyNumber = self.rallyArray.count-1;
    }
    
    
    else {
        currentRallyNumber = [self.rallyArray indexOfObject:currentRally];
        currentRallyNumber--;
        
    }  
    currentRally = [self.rallyArray objectAtIndex:currentRallyNumber];    
    return currentRally;
}

//Find Next Rally
- (Rally *)nextRally {
    int currentRallyNumber = [self.rallyArray indexOfObject:currentRally];
    currentRallyNumber++;
    
    if (currentRallyNumber < [self.rallyArray count]) {
        currentRally = [self.rallyArray objectAtIndex:currentRallyNumber];
        return currentRally;
    }
    currentRally = NULL;
    return NULL;
}

- (void)addNewCourtImage {
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(courtTapped:)];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(courtPanned:)];
        
    CourtView *newCourt = [[CourtView alloc] initWithFrame:imageFrameBig];
    //newCourt.image = [UIImage imageNamed:@"Default.png"];
    newCourt.frame = imageFrameBig;
    newCourt.drawDot = NO;
    newCourt.layer.zPosition = [[self.view.superview subviews] count]+5;
    //newCourt.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:newCourt];
    [newCourt setUserInteractionEnabled:YES];
    [newCourt addGestureRecognizer:tapRecognizer];
    [newCourt addGestureRecognizer:panRecognizer];
    
    self.courtView = newCourt;
    
    self.topOverlayView.layer.zPosition = newCourt.layer.zPosition+1;
    
}

- (void)editButtonPressed {
    
    if (entryViewUp == false) {
        
        [(UIStepper *)self.p1Stepper setValue:p1Score];
        [(UIStepper *)self.p2Stepper setValue:p2Score];
        [(UIStepper *)self.gameStepper setValue:gameNumber];
        [self playerScoreChanged:nil];
        [self gameNumberChanged:nil];
        
        if  (currentRally.p1Finished.boolValue) {
            [self.playerSegControl setSelectedSegmentIndex:0];
        }
        else [self.playerSegControl setSelectedSegmentIndex:1];
        
        int shot = currentRally.finishingShot.intValue;
        if (shot < 3) {
            [self.shotSegControlTop setSelectedSegmentIndex:shot];
            [self.shotSegControlBottom setSelectedSegmentIndex:-1];

        }
        else {
            [self.shotSegControlBottom setSelectedSegmentIndex:shot-3];
            [self.shotSegControlTop setSelectedSegmentIndex:-1];
        }
        
        [self.entryScrollView setContentSize:CGSizeMake(640, 380)];
        [self.entryScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        [self.pageControl setAlpha:1.0];

        
//        leftTopButton.title = @"Cancel Shot";
        
        [UIView animateWithDuration:0.5 
                         animations:^{
                             self.topOverlayView.frame = CGRectMake(0, 43, 320, 0);
                             
                             self.entryView.frame = entryViewFrameUp;
                             self.courtView.frame = imageFrameSmall;
                             CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI/2.0);
                             self.courtView.transform = rotate;
                             self.opaqueView.alpha = 0.5;
                             
                         }
                         completion:^(BOOL finished){
                             //Set Bool
                             entryViewUp = true;
                             [self.entryScrollView addSubview:self.courtView];
                             
                             
                             //Add Court View to Entry Scroll View
                             [self.courtView setFrame:CGRectMake(self.courtView.frame.origin.x, self.courtView.frame.origin.y-43, self.courtView.frame.size.width, self.courtView.frame.size.height)];
                             self.courtView.tag = 1024;
                             
                             
                         }];
    }


}


- (void)setCourtView {
    int p1GameScore = 0;
    int p2GameScore = 0;

    
    int gNumber = gameNumber;
    if (currentRally != NULL) {
        gNumber = ((Game *)currentRally.game).number.intValue;
    }
    
    NSArray *games = [self.match.games sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES]]];
    for (int i = 0; i < gNumber-1; i++) {
        Rally *tempRally = [[[[games objectAtIndex:i] rallies] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pointNumber" ascending:YES]]] lastObject];
        if (tempRally.p1Score.intValue > tempRally.p2Score.intValue) {
            p1GameScore++;
        }
        else if (tempRally.p1Score.intValue < tempRally.p2Score.intValue) {
            p2GameScore++;
        }
    }
    
    self.title = [NSString stringWithFormat:@"%@ %u - %u %@", [self.match.player1 getName:kFirstInitialLastName], p1GameScore, p2GameScore, [self.match.player2 getName:kFirstInitialLastName]];
    
    if (currentRally) {
        
        // Old Shot
        if (self.navigationItem.rightBarButtonItem == NULL) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(rightButtonPressed:)];
        }
        
        [self.courtView setX:currentRally.xPosition.doubleValue 
                        andY:currentRally.yPosition.doubleValue];
        self.scoreItemButton.title = [NSString stringWithFormat:@"%@ %u - %u %@", [self.match.player1 getName:kFirstInitialLastName], currentRally.p1Score.intValue, currentRally.p2Score.intValue, [self.match.player2 getName:kFirstInitialLastName]];

        NSString *player = (currentRally.p1Finished.boolValue) ? [self.match.player1 getName:kFirstInitialLastName] : [self.match.player2 getName:kFirstInitialLastName];
        
        int prevp1score = [currentRally getPreviousp1Score];
        int prevp2score = [currentRally getPreviousp2Score];
        self.topOverlaySubtitle.text = @"Click Edit To Edit Shot";
        switch (currentRally.finishingShot.intValue) {
            case kWinner:
                self.topOverlayTitle.text = [NSString stringWithFormat:@"At %u-%u in game %u, %@ Hits A Winner",prevp1score, prevp2score, gNumber, player];
                break;
            case kUnforcedError:
                self.topOverlayTitle.text = [NSString stringWithFormat:@"At %u-%u in game %u, %@ Makes An Unforced Error",prevp1score, prevp2score, gNumber, player];
                break;
            case kError:
                self.topOverlayTitle.text = [NSString stringWithFormat:@"At %u-%u in game %u, %@ Makes An Error",prevp1score, prevp2score, gNumber, player];
                break;
            case kNoLet:
                self.topOverlayTitle.text = [NSString stringWithFormat:@"At %u-%u in game %u, %@ Not Awarded A Let",prevp1score, prevp2score, gNumber, player];
                break;
            case kLet:
                self.topOverlayTitle.text = [NSString stringWithFormat:@"At %u-%u in game %u, %@ Awarded A Let",prevp1score, prevp2score, gNumber, player];
                break;
            case kStroke:
                self.topOverlayTitle.text = [NSString stringWithFormat:@"At %u-%u in game %u, %@ Awarded A Stroke",prevp1score, prevp2score, gNumber, player];
                break;
                
            default:
                break;
        }
        
        
        //self.topOverlaySubtitle.text = [NSString stringWithFormat:@"Tap edit to edit shot"];
        
        [self.topOverlayView.layer removeAllAnimations];
        [UIView animateWithDuration:0.3 animations:^{
            self.topOverlayView.frame = CGRectMake(0, 0, 320, 41);
        }];
        
    }
    else  { 
        
        if (self.navigationItem.rightBarButtonItem) self.navigationItem.rightBarButtonItem = NULL;
        
        // New Shot
        self.scoreItemButton.title = [NSString stringWithFormat:@"%@ %u - %u %@", [self.match.player1 getName:kFirstInitialLastName], p1Score, p2Score, [self.match.player2 getName:kFirstInitialLastName]];
        
        self.topOverlayTitle.text = [NSString stringWithFormat:@"Log New Shot",p1Score, p2Score];
        
        self.topOverlaySubtitle.text = [NSString stringWithFormat:@"Tap on court to add location for shot"];
        
        [self.courtView removeDot];
        
        [self.topOverlayView.layer removeAllAnimations];
        [UIView animateWithDuration:0.3 delay:2.0 options:UIViewAnimationCurveEaseIn animations:^{
            self.topOverlayView.frame = CGRectMake(0, 0, 320, 0);
            
        }completion:^(BOOL complete){
            
        }];
        
    }
    
    //Enable Buttons
    if ([self.rallyArray indexOfObject:currentRally] == 0) {
        self.previousRallyButton.enabled = NO;
    }
    else self.previousRallyButton.enabled = YES;
    
    if (!currentRally) {
        self.nextRallyButton.enabled = NO;
        [self.courtView setUserInteractionEnabled:YES];
    }
    else {
        self.nextRallyButton.enabled = YES;
        [self.courtView setUserInteractionEnabled:NO];
    }
    
    
}

- (void)resetEntryView {
    [self.entryScrollView setContentSize:CGSizeMake(320, 380)];
    [self.entryScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.pageControl setAlpha:0.0];
    
    [self.playerSegControl setSelectedSegmentIndex:-1];
    [self.shotSegControlBottom setSelectedSegmentIndex:-1];
    [self.shotSegControlTop setSelectedSegmentIndex:-1];
    
}
- (void)initEntryView {
    
    [self addNewCourtImage];
    
    [self.entryView addSubview:self.entryScrollView];
    [self.entryScrollView setPagingEnabled:YES];
    [self.entryScrollView setScrollEnabled:YES];
    [self.entryScrollView setDelegate:self];
    
    [self.entryScrollView setBackgroundColor:[UIColor clearColor]];
    [self.entryScrollView setFrame:CGRectMake(0, 0, self.entryView.frame.size.width, self.entryView.frame.size.height)];
    
    [self.playerSegControl setTintColor:[UIColor redColor]];
    [self.playerSegControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    
    [self.shotSegControlBottom setTintColor:[UIColor redColor]];
    [self.shotSegControlBottom setSegmentedControlStyle:UISegmentedControlStyleBar];
    
    [self.shotSegControlTop setTintColor:[UIColor redColor]];
    [self.shotSegControlTop setSegmentedControlStyle:UISegmentedControlStyleBar];
    
    //self.p1NameLabel.text = [self.match.player1 getName:kFirstInitialLastName];
   // self.p2NameLabel.text = [self.match.player1 getName:kFirstInitialLastName];
    
    self.p1ScoreNameLabel.text = [self.match.player1 getName:kFirstInitialLastName];
    self.p2ScoreNameLabel.text = [self.match.player2 getName:kFirstInitialLastName];

    [self.playerSegControl setTitle:[self.match.player1 getName:kFirstInitialLastName] forSegmentAtIndex:0];
    [self.playerSegControl setTitle:[self.match.player2 getName:kFirstInitialLastName] forSegmentAtIndex:1];
    
    [self resetEntryView];
    [self setCourtView];
    
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.bottomToolbar setTintColor:[UIColor redColor]];
//    [self.topToolbar setTintColor:[UIColor redColor]];
    [self.topToolbar removeFromSuperview];
    
    [self addSteppers];
    
    gameNumber = 1;
    p1Score = 0;
    p2Score = 0;
    
    
    [self.view setBackgroundColor:[UIColor colorWithRed:253.0/255.0 green:250.0/255.0 blue:212.0/255.0 alpha:1.0]];
    
    [self.view addSubview:self.entryView];
    entryViewFrameDown = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.entryView.frame.size.height);
    entryViewFrameUp = CGRectMake(0, 0, self.view.frame.size.width, self.entryView.frame.size.height);
    
    imageFrameBig = self.courtImage.frame;
    imageFrameSmallTemp = CGRectMake(90, 5, 140, 212);
    
    imageFrameSmall = CGRectMake(90, 28-43, 140, 212);
    entryViewUp = false;
    
    self.entryView.frame = entryViewFrameDown;
    
    [self initEntryView];
    
    leftTopButton = [[UIBarButtonItem alloc] initWithTitle:@"Finish" style:UIBarButtonItemStyleBordered target:self action:@selector(leftButtonPressed:)];
    
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = leftTopButton;
    
    self.title = [NSString stringWithFormat:@"%@ 0 - 0 %@", [self.match.player1 getName:kFirstInitialLastName], [self.match.player2 getName:kFirstInitialLastName]];
    
    self.rallyArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSArray *buttonArray = [NSArray arrayWithObjects:self.rallyDoneButton, self.rallyWithGameDoneButton, nil];
    for (UIButton *button in buttonArray) {
        [button setBackgroundImage:[[UIImage imageNamed:@"RedButton.png"] stretchableImageWithLeftCapWidth:10.0f topCapHeight:0.0f] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [button.titleLabel setMinimumFontSize:12];
        button.titleLabel.shadowColor = [UIColor lightGrayColor];
        button.titleLabel.shadowOffset = CGSizeMake(0, -1);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Entry Shot Actions

- (void)upEntryView:(UIView *)view {
    [(UIStepper *)self.p1Stepper setValue:p1Score];
    [(UIStepper *)self.p2Stepper setValue:p2Score];
    [(UIStepper *)self.gameStepper setValue:gameNumber];
    [self playerScoreChanged:nil];
    [self gameNumberChanged:nil];
    
    leftTopButton.title = @"Cancel Shot";
    
    if (currentRally != NULL) {
        if  (currentRally.p1Finished.boolValue) {
            [self.playerSegControl setSelectedSegmentIndex:0];
        }
        else [self.playerSegControl setSelectedSegmentIndex:1];
        
        int shot = currentRally.finishingShot.intValue;
        if (shot < 3) {
            [self.shotSegControlTop setSelectedSegmentIndex:shot];
            [self.shotSegControlBottom setSelectedSegmentIndex:-1];
            
        }
        else {
            [self.shotSegControlBottom setSelectedSegmentIndex:shot-3];
            [self.shotSegControlTop setSelectedSegmentIndex:-1];
        }
        
        [self.entryScrollView setContentSize:CGSizeMake(640, 380)];
        [self.entryScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        [self.pageControl setAlpha:1.0];

    }
        
    [UIView animateWithDuration:0.5 
                     animations:^{
                         self.topOverlayView.frame = CGRectMake(0, 0, 320, 0);
                         
                         self.entryView.frame = entryViewFrameUp;
                         view.frame = imageFrameSmall;
                         CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI/2.0);
                         view.transform = rotate;
                         self.opaqueView.alpha = 0.5;
                         
                     }
                     completion:^(BOOL finished){
                         //Set Bool
                         entryViewUp = true;
                         [self.entryScrollView addSubview:view];
                         
                         
                         
                         //Add Court View to Entry Scroll View
//                         [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
                         view.tag = 1024;
                         
                         
                     }];
}

- (void)courtPanned:(UIGestureRecognizer *)sender {
    CourtView *tempCourtView = (CourtView *)sender.view;
    CGPoint location = [(UITapGestureRecognizer *)sender locationInView:sender.view];

    double xPercent = location.x/(sender.view.frame.size.width);
    double yPercent = location.y/(sender.view.frame.size.height);
    xVal = xPercent;
    yVal = yPercent;
    if (entryViewUp) {
        xPercent = location.x/(sender.view.frame.size.height);
        yPercent = location.y/(sender.view.frame.size.width);
        xVal = xPercent;
        yVal = yPercent;
    }
    

    if (sender.state == UIGestureRecognizerStateBegan) {
        tempCourtView.drawGuides = TRUE;
        [tempCourtView setX:xPercent andY:yPercent];
    }
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
        [tempCourtView setX:xPercent andY:yPercent];
        
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        tempCourtView.drawGuides = FALSE;
        if (xPercent > 1 || xPercent < 0 || yPercent < 0 || yPercent > 1) {
            tempCourtView.drawDot = NO;
            return;
        }
        [tempCourtView setX:xPercent andY:yPercent];
        
        if (entryViewUp == false) {
                    
            [self upEntryView:sender.view];
        }
        
    }
}

- (void)courtTapped:(UIGestureRecognizer *)sender {
    CGPoint location = [(UITapGestureRecognizer *)sender locationInView:sender.view];
    CourtView *tempCourtView = (CourtView *)sender.view;

    
    if (sender.state == UIGestureRecognizerStateEnded) {
        double xPercent = location.x/(sender.view.frame.size.width);
        double yPercent = location.y/(sender.view.frame.size.height);
        xVal = xPercent;
        yVal = yPercent;
        if (entryViewUp) {
            xPercent = location.x/(sender.view.frame.size.height);
            yPercent = location.y/(sender.view.frame.size.width);
            xVal = xPercent;
            yVal = yPercent;
        }
        
        [tempCourtView setX:xPercent andY:yPercent];
        
        if (entryViewUp == false) {
            [self upEntryView:sender.view];
        }
        
    }
}

- (void)rightButtonPressed:(UIBarButtonItem *)sender {    
    if (entryViewUp == false) {
        [self upEntryView:self.courtView];
        self.navigationItem.leftBarButtonItem = NULL;
        self.navigationItem.rightBarButtonItem = NULL;
    }
}

- (void)leftButtonPressed:(UIBarButtonItem *)sender {
    if (sender.title == @"Cancel Shot") {
        sender.title = @"Finish";
        entryViewUp = false;
        
        [UIView animateWithDuration:0.5 
                         animations:^{
                             self.entryView.frame = entryViewFrameDown;
                             self.opaqueView.alpha = 0.0;
                             
                         }
                         completion:^(BOOL finished){
                             
                             [self addNewCourtImage];
                             [[self.view viewWithTag:1024] removeFromSuperview];
                             entryViewUp = false;
                             
                             currentRally = NULL;
                             [self resetEntryView];
                             [self setCourtView];
                             
                             
                         }];
        return;
        
        
    }
    
//    Finish button was pressed
    if (gameNumber == 1 && currentGame.rallies.count == 0) {
        [self.managedObjectContext deleteObject:self.match];
        
        int count = [self.navigationController.viewControllers count];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count-4] animated:YES];
        return;
        
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Do You Want To Save This Match?" delegate:self cancelButtonTitle:@"Don't End Match" destructiveButtonTitle:@"Yes, Save It" otherButtonTitles:@"No, Don't Save It", nil];
    actionSheet.tag = 2;
    [actionSheet showInView:self.view];

//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Are You Sure You Want To End The Match" delegate:self cancelButtonTitle:@"No, Don't End Match" destructiveButtonTitle:@"Yes, End Match" otherButtonTitles:nil];
//    sheet.tag = 1;
//    [sheet showInView:self.view];
}

- (void)saveCurrentRally {
    SCRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [appDelegate managedObjectContext];

    
    Rally *rally = currentRally;
    BOOL newrally = FALSE;
    if (!rally) {
        rally = [NSEntityDescription insertNewObjectForEntityForName:@"Rally" inManagedObjectContext:moc];
        newrally = TRUE;
        
    }
    currentGame = [[self.match.games objectsPassingTest:^BOOL(id obj, BOOL *stop) {
        Game *game = (Game *)obj;
        return (game.number.intValue == gameNumber);
    }] anyObject];
    
    if (!currentGame) {
        currentGame = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:moc];
        currentGame.number = [NSNumber numberWithInt:gameNumber];
        if (newrally) {
            rally.pointNumber = [NSNumber numberWithInt:0];

        }
        [self.match addGamesObject:currentGame];
    }
    else {
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"pointNumber.intValue" ascending:YES];
        NSArray *gameRallies = [currentGame.rallies sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
        if (newrally) {
            rally.pointNumber = [NSNumber numberWithInt:[[gameRallies lastObject] pointNumber].intValue + 1];

        }
    }
    
    

    rally.p1Score = [NSNumber numberWithInt:p1Score];
    rally.p2Score = [NSNumber numberWithInt:p2Score];
    rally.xPosition = [NSNumber numberWithDouble:xVal];
    rally.yPosition = [NSNumber numberWithDouble:yVal];
    rally.game = currentGame;
    rally.p1Finished = [NSNumber numberWithBool:(self.playerSegControl.selectedSegmentIndex == 0)];
    rally.player = (rally.p1Finished.boolValue) ? self.match.player1 : self.match.player2;
    
    if (self.shotSegControlTop.selectedSegmentIndex > -1) {
        rally.finishingShot = [NSNumber numberWithInt:self.shotSegControlTop.selectedSegmentIndex];
        
    }
    else     
        rally.finishingShot = [NSNumber numberWithInt:(self.shotSegControlBottom.selectedSegmentIndex+3)];
    
    if (newrally) {
        [self.rallyArray addObject:rally];

    }
    
    for (Game *game in self.match.games) {
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"pointNumber.intValue" ascending:YES];
        NSArray *gameRallies = [game.rallies sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
        
        for (Rally *rally in gameRallies) {
            NSLog(@"Game Number - %u, Rally Number - %u", game.number.intValue, rally.pointNumber.intValue);
        }

    }
    

}
- (IBAction)doneWithGameDoneButtonPressed:(UIButton *)sender {
    
    
    [self doneButtonPressed:nil];
    
    p1Score = 0;
    p2Score = 0;
    gameNumber++;
    [self setCourtView];

    
    NSRange range = [sender.titleLabel.text rangeOfString:@"Match"]; 
    if (range.location != NSNotFound) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Do You Want To Save This Match?" delegate:self cancelButtonTitle:@"Don't End Match" destructiveButtonTitle:@"Yes, Save It" otherButtonTitles:@"No, Don't Save It", nil];
        actionSheet.tag = 2;
        [actionSheet showInView:self.view];
    }
}

- (IBAction)doneButtonPressed:(id)sender {

    BOOL newShot = !currentRally;
    entryViewUp = false;
    
    p1Score =  [(UIStepper *)self.p1Stepper value];
    p2Score = [(UIStepper *)self.p2Stepper value];
    gameNumber = [(UIStepper *)self.gameStepper value];

    [self saveCurrentRally];
    
    if (self.navigationItem.leftBarButtonItem.title == NULL) {
        self.navigationItem.leftBarButtonItem = leftTopButton;  
    }
    else     self.navigationItem.leftBarButtonItem.title = @"Finish";

    

    [UIView animateWithDuration:0.5 
                     animations:^{
                         self.entryView.frame = entryViewFrameDown;
                         self.opaqueView.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){
                         [self addNewCourtImage];
                         [[self.view viewWithTag:1024] removeFromSuperview];
                         entryViewUp = false;
                         
                         
                         //scroll view
                         currentRally = NULL;
                         [self resetEntryView];
                         if (!newShot) {
                             [self previousRally];

                         }
                         [self setCourtView];
                         
                         
                     }];
}



-(void)checkIfSegsPicked {
    if (([self.shotSegControlTop selectedSegmentIndex] > -1 ||
         [self.shotSegControlBottom selectedSegmentIndex] > -1) &&
        [self.playerSegControl selectedSegmentIndex] > -1 &&
        self.entryScrollView.contentSize.width == 320) {
        [self.entryScrollView setContentSize:CGSizeMake(640, 380)];
        [self.entryScrollView setContentOffset:CGPointMake(320, 0) animated:YES];
        [UIView animateWithDuration:0.5 animations:^ {
            [self.pageControl setAlpha:1.0];
            
        }];
        
        // Set Top Bar
        NSArray *items = self.topToolbar.items;
        [self.topToolbar setItems:[items arrayByAddingObject:[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonPressed:)]] animated:YES];
        
        //Update Score
        if (self.shotSegControlTop.selectedSegmentIndex > -1) {
            if (self.shotSegControlTop.selectedSegmentIndex == kWinner) {
                if (self.playerSegControl.selectedSegmentIndex == 0) {
                    [(UIStepper *)self.p1Stepper setValue:[(UIStepper *)self.p1Stepper value]+1];
                }
                else [(UIStepper *)self.p2Stepper setValue:[(UIStepper *)self.p2Stepper value]+1];
            }
            else if (self.shotSegControlTop.selectedSegmentIndex == kUnforcedError || self.shotSegControlTop.selectedSegmentIndex == kError) {
                if (self.playerSegControl.selectedSegmentIndex == 0) {
                    [(UIStepper *)self.p2Stepper setValue:[(UIStepper *)self.p2Stepper value]+1];
                }
                else [(UIStepper *)self.p1Stepper setValue:[(UIStepper *)self.p1Stepper value]+1];
            }

        }
        else {
            switch (self.shotSegControlBottom.selectedSegmentIndex + 3) {
                case kNoLet: {
                    if (self.playerSegControl.selectedSegmentIndex == 0) {
                        [(UIStepper *)self.p2Stepper setValue:[(UIStepper *)self.p2Stepper value]+1];
                    }
                    else [(UIStepper *)self.p1Stepper setValue:[(UIStepper *)self.p1Stepper value]+1];
                    break;
                }
                case kLet: {
                    break;
                }
                case kStroke: {
                    if (self.playerSegControl.selectedSegmentIndex == 0) {
                        [(UIStepper *)self.p1Stepper setValue:[(UIStepper *)self.p1Stepper value]+1];
                    }
                    else [(UIStepper *)self.p2Stepper setValue:[(UIStepper *)self.p2Stepper value]+1];
                    break;
                }
                    
                default:
                    break;
            }
            
        }
        
        
        [self playerScoreChanged:nil];
    }
}

-(IBAction)playerSegChanged:(id)sender {
    [self checkIfSegsPicked];
}

-(IBAction)topShotSegChanged:(id)sender {
    if ([self.shotSegControlBottom selectedSegmentIndex] > -1) {
        [self.shotSegControlBottom setSelectedSegmentIndex:-1];
    }
    
    [self checkIfSegsPicked];
    
}

-(IBAction)bottomShotSegChanged:(id)sender {
    if ([self.shotSegControlTop selectedSegmentIndex] > -1) {
        [self.shotSegControlTop setSelectedSegmentIndex:-1];
    }
    
    [self checkIfSegsPicked];
    
}

-(void)endMatch {
    if (self.rallyArray.count == 0) {
        [self.managedObjectContext deleteObject:self.match];
        // Remove match
    }
    
    int p1GameScore = 0;
    int p2GameScore = 0;
    NSArray *games = [self.match.games sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES]]];
    for (Game *game in games) {
        Rally *tempRally = [[game.rallies sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pointNumber" ascending:YES]]] lastObject];
        if (tempRally.p1Score.intValue > tempRally.p2Score.intValue) {
            p1GameScore++;
        }
        else if (tempRally.p1Score.intValue < tempRally.p2Score.intValue) {
            p2GameScore++;
        }
        game.p1Score = [NSNumber numberWithInt:tempRally.p1Score.intValue];
        game.p2Score = [NSNumber numberWithInt:tempRally.p2Score.intValue];
    }
    
    self.match.p1GameScore = [NSNumber numberWithInt:p1GameScore];
    self.match.p2GameScore = [NSNumber numberWithInt:p2GameScore];

    [(SCRAppDelegate *)[[UIApplication sharedApplication] delegate] saveContext];

    [self.delegate popToMatchOverview:self.match];  
}

-(void)finishButtonPressed {
    if (self.navigationItem.leftBarButtonItem.title == @"Cancel Shot") {
        self.navigationItem.leftBarButtonItem.title = @"Finish";
        entryViewUp = false;
        NSMutableArray *items = [NSMutableArray arrayWithArray:self.topToolbar.items];
        UIBarButtonItem *item = [items lastObject];
        if (item.title == @"Done") {
            [items removeLastObject];
            [self.topToolbar setItems:items animated:YES];
        }
        
        
        [UIView animateWithDuration:0.5 
                         animations:^{
                             self.entryView.frame = entryViewFrameDown;
                             self.opaqueView.alpha = 0.0;
                             
                         }
                         completion:^(BOOL finished){
                                                          
                             [self addNewCourtImage];
                             [[self.view viewWithTag:1024] removeFromSuperview];
                             entryViewUp = false;
                             
                             currentRally = NULL;
                             [self resetEntryView];
                             [self setCourtView];
                             
                             
                         }];
        return;
        

    }
    if (gameNumber == 1 && currentGame.rallies.count == 0) {
        [self.managedObjectContext deleteObject:self.match];

        int count = [self.navigationController.viewControllers count];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count-4] animated:YES];
        return;

    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Do You Want To Save This Match?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Yes, Save It" otherButtonTitles:@"No, Don't Save It", nil];
    actionSheet.tag = 2;
    [actionSheet showInView:self.view];
    
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Are You Sure You Want To End The Match" delegate:self cancelButtonTitle:@"No, Don't End Match" destructiveButtonTitle:@"Yes, End Match" otherButtonTitles:nil];
//    sheet.tag = 1;
//    [sheet showInView:self.view];

}


-(IBAction)playerScoreChanged:(id)sender {
    self.p1ScoreLabel.text = [NSString stringWithFormat:@"%u", (int)[(UIStepper *)p1Stepper value]];
    self.p2ScoreLabel.text = [NSString stringWithFormat:@"%u", (int)[(UIStepper *)p2Stepper value]];
    
    self.rallyWithGameDoneButton.hidden = TRUE;
    [self.rallyDoneButton setTitle:@"Save Rally" forState:UIControlStateNormal];
    
    int p1GameScore = 0;
    int p2GameScore = 0;
    NSArray *games = [self.match.games sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES]]];
    for (Game *game in games) {
        Rally *tempRally = [[game.rallies sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pointNumber" ascending:YES]]] lastObject];
        if (tempRally.p1Score.intValue > tempRally.p2Score.intValue) {
            p1GameScore++;
        }
        else if (tempRally.p1Score.intValue < tempRally.p2Score.intValue) {
            p2GameScore++;
        }
    }
    
    self.match.p1GameScore = [NSNumber numberWithInt:p1GameScore];
    self.match.p2GameScore = [NSNumber numberWithInt:p2GameScore];

    
    BOOL endMatch = (gameNumber >= self.match.numberOfGames.intValue/2+1);
    
    if ((int)[(UIStepper *)p1Stepper value] >= self.match.pointsPerGame.intValue && (int)[(UIStepper *)p1Stepper value] > (int)[(UIStepper *)p2Stepper value]) {
        self.rallyWithGameDoneButton.hidden = FALSE;
        [self.rallyDoneButton setTitle:[NSString stringWithFormat:@"%@ Didn't Win Game %u", [self.match.player1 getName:kFirstInitialLastName], (int)[(UIStepper *)self.gameStepper value]] forState:UIControlStateNormal];

        
        [self.rallyWithGameDoneButton setTitle:[NSString stringWithFormat:@"%@ Wins Game %u", [self.match.player1 getName:kFirstInitialLastName], (int)[(UIStepper *)self.gameStepper value]] forState:UIControlStateNormal];
        
        if (p1GameScore >= ceil(self.match.numberOfGames.intValue/2) && p1GameScore >= p2GameScore) {
            [self.rallyWithGameDoneButton setTitle:[self.rallyWithGameDoneButton.titleLabel.text stringByAppendingString:@" and Match"] forState:UIControlStateNormal];

        }
        
    }
    else if ((int)[(UIStepper *)p2Stepper value] >= self.match.pointsPerGame.intValue && (int)[(UIStepper *)p2Stepper value] > (int)[(UIStepper *)p1Stepper value]) {
        self.rallyWithGameDoneButton.hidden = FALSE;
        [self.rallyDoneButton setTitle:[NSString stringWithFormat:@"%@ Didn't Win Game %u", [self.match.player2 getName:kFirstInitialLastName], (int)[(UIStepper *)self.gameStepper value]] forState:UIControlStateNormal];

        [self.rallyWithGameDoneButton setTitle: [NSString stringWithFormat:@"%@ Wins Game %u", [self.match.player2 getName:kFirstInitialLastName], (int)[(UIStepper *)self.gameStepper value]] forState:UIControlStateNormal];
        
        if (p2GameScore >= ceil(self.match.numberOfGames.intValue/2) && p2GameScore >= p1GameScore) {
            [self.rallyWithGameDoneButton setTitle:[self.rallyWithGameDoneButton.titleLabel.text stringByAppendingString:@" and Match"] forState:UIControlStateNormal];
            
        }

    }
    
}
-(IBAction)gameNumberChanged:(id)sender {
    self.gameNumberLabel.text = [NSString stringWithFormat:@"%u", (int)[(UIStepper *)self.gameStepper value]];
    
}

- (IBAction)rewindButtonPressed:(id)sender {
    [self previousRally];
    [self setCourtView];
}

- (IBAction)fastFowardButtonPressed:(id)sender {
    [self nextRally];
    [self setCourtView];
    
}

- (IBAction)scoreButtonPressed:(id)sender {
    
}


#pragma mark - Paging Delegats
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > 320/2) {
        [self.pageControl setCurrentPage:1];
    }
    else [self.pageControl setCurrentPage:0];
}

- (IBAction)pageControlChanged:(id)sender {
    int y = 0;
    int x = self.pageControl.currentPage * 320;
    [self.entryScrollView setContentOffset:CGPointMake(x, y) animated:YES];
}

#pragma mark - Action Sheet Delegate


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    switch (actionSheet.tag) {
        case 1:
            if (buttonIndex == 0) {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Do You Want To Save This Match?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Yes, Save It" otherButtonTitles:@"No, Don't Save It", nil];
                actionSheet.tag = 2;
                [actionSheet showInView:self.view];
                
            }
            break;
        case 2:
            if (buttonIndex == 0) {
                [self endMatch];
                
            }
            if (buttonIndex == 1) {
                [self.managedObjectContext deleteObject:self.match];
                
                int count = [self.navigationController.viewControllers count];
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count-4] animated:YES];
                
            }
            break;
            
        default:
            break;
    }
    
}




@end
