//
//  RallyEntryController.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RallyEntryController.h"
#import "SCRAppDelegate.h"

@implementation RallyEntryController

@synthesize managedObjectContext, match, courtImage, bottomToolbar, titleButton, entryView, entryScrollView, p1NameLabel, p1ScoreLabel, p2NameLabel, p2ScoreLabel, gameNumberLabel, p1Stepper, p2Stepper, gameStepper, p1ScoreNameLabel, p2ScoreNameLabel, topToolbar, opaqueView, playerSegControl, shotSegControlTop, shotSegControlBottom, pageControl, scoreItemButton, gameArray, gameDic, rallyArray, courtView, previousRallyButton, nextRallyButton, topOverlayView, topOverlayTitle, topOverlaySubtitle, gameWonLabel;

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
    if (self.rallyArray.count == 0) {
        [self.rallyArray addObject:currentRally];
    }
    else {
        for (int i = 0; i < self.rallyArray.count+1; i++) {
            if (i == self.rallyArray.count) {
                [self.rallyArray addObject:currentRally];
                break;
                
            }
            
            Rally *tempRally = [self.rallyArray objectAtIndex:i]; 
            Game *game = (Game *)tempRally.game;
            if (game.number.intValue == gmNumber && (tempRally.p1Score.intValue + tempRally.p2Score.intValue) < pntNumber) {
                i++;
                while ((tempRally.p1Score.intValue + tempRally.p2Score.intValue) < pntNumber && i < self.rallyArray.count) {
                    tempRally = [self.rallyArray objectAtIndex:i];
                    i++;
                }
                [self.rallyArray insertObject:currentRally atIndex:i];
                break;
            }
            if (game.number.intValue < gmNumber && (tempRally.p1Score.intValue + tempRally.p2Score.intValue) < pntNumber) {
                [self.rallyArray insertObject:currentRally atIndex:i];
                break;
            }
        }
    }
    
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
    return NULL;
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
    tapRecognizer.numberOfTapsRequired = 1;
    
    CourtView *newCourt = [[CourtView alloc] initWithFrame:imageFrameBig];
    //newCourt.image = [UIImage imageNamed:@"Default.png"];
    newCourt.frame = imageFrameBig;
    newCourt.drawDot = NO;
    newCourt.layer.zPosition = [[self.view.superview subviews] count]+5;
    //newCourt.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:newCourt];
    [newCourt setUserInteractionEnabled:YES];
    [newCourt addGestureRecognizer:tapRecognizer];
    
    self.courtView = newCourt;
    
    self.topOverlayView.layer.zPosition = newCourt.layer.zPosition+1;
    
}

- (void)setCourtView {
    if (currentRally) {
        
        // Old Shot
        [self.courtView setX:currentRally.xPosition.doubleValue 
                        andY:currentRally.yPosition.doubleValue];
        self.scoreItemButton.title = [NSString stringWithFormat:@"%@ %u - %u %@", self.match.player1.lastName, currentRally.p1Score.intValue, currentRally.p2Score.intValue, self.match.player2.lastName];
        NSString *player = (currentRally.p1Finished.boolValue) ? self.match.player1.lastName : self.match.player2.lastName;
        int prevp1score = [currentRally getPreviousp1Score];
        int prevp2score = [currentRally getPreviousp2Score];
        switch (currentRally.finishingShot.intValue) {
            case kWinner:
                self.topOverlayTitle.text = [NSString stringWithFormat:@"At %u-%u, %@ Hits Winner",prevp1score, prevp2score, player];
                break;
            case kUnforcedError:
                self.topOverlayTitle.text = [NSString stringWithFormat:@"At %u-%u, %@ Makes An Unforced Error",prevp1score, prevp2score, player];
                break;
            case kError:
                self.topOverlayTitle.text = [NSString stringWithFormat:@"At %u-%u, %@ Makes An Error",prevp1score, prevp2score, player];
                break;
            case kNoLet:
                self.topOverlayTitle.text = [NSString stringWithFormat:@"At %u-%u, %@ Does Not Recieve Let",prevp1score, prevp2score, player];
                break;
            case kLet:
                self.topOverlayTitle.text = [NSString stringWithFormat:@"At %u-%u, %@ Recieves Let",prevp1score, prevp2score, player];
                break;
            case kStroke:
                self.topOverlayTitle.text = [NSString stringWithFormat:@"At %u-%u, %@ Recieves Stroke",prevp1score, prevp2score, player];
                break;
                
            default:
                break;
        }
        
        
        //self.topOverlaySubtitle.text = [NSString stringWithFormat:@"Tap edit to edit shot"];
        
        [self.topOverlayView.layer removeAllAnimations];
        [UIView animateWithDuration:0.3 animations:^{
            self.topOverlayView.frame = CGRectMake(0, 43, 320, 41);
        }];
        
    }
    else  { 
        
        // New Shot
        self.scoreItemButton.title = [NSString stringWithFormat:@"%@ %u - %u %@", self.match.player1.lastName, p1Score, p2Score, self.match.player2.lastName];
        self.topOverlayTitle.text = [NSString stringWithFormat:@"Log New Shot",p1Score, p2Score];
        
        self.topOverlaySubtitle.text = [NSString stringWithFormat:@"Tap on court to add location for shot"];
        
        [self.courtView removeDot];
        
        [self.topOverlayView.layer removeAllAnimations];
        [UIView animateWithDuration:0.3 delay:2.0 options:UIViewAnimationCurveEaseIn animations:^{
            self.topOverlayView.frame = CGRectMake(0, 43, 320, 0);
            
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
    [self.topToolbar setTintColor:[UIColor redColor]];
    
    gameNumber = 1;
    p1Score = 0;
    p2Score = 0;
    
    
    [self.view setBackgroundColor:[UIColor colorWithRed:253.0/255.0 green:250.0/255.0 blue:212.0/255.0 alpha:1.0]];
    
    [self.view addSubview:self.entryView];
    entryViewFrameDown = CGRectMake(0, self.view.frame.size.height+60, self.view.frame.size.width, self.entryView.frame.size.height);
    entryViewFrameUp = CGRectMake(0, 43, self.view.frame.size.width, self.entryView.frame.size.height);
    
    imageFrameBig = self.courtImage.frame;
    imageFrameSmall = CGRectMake(90, 28, 140, 212);
    entryViewUp = false;
    
    self.entryView.frame = entryViewFrameDown;
    
    [self initEntryView];
    
    [self.topToolbar setItems:[NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc] initWithTitle:@"Finish" style:UIBarButtonItemStyleBordered target:self action:@selector(finishButtonPressed)],
                               [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] , nil]];
    

    // Do any additional setup after loading the view from its nib.
   // SCRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.rallyArray = [[NSMutableArray alloc] initWithCapacity:0];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Entry Shot Actions


- (void)courtTapped:(UIGestureRecognizer *)sender {
    if (entryViewUp == false) {
        
        
        if (sender.state == UIGestureRecognizerStateEnded) {
            [sender.view setUserInteractionEnabled:NO];
            CGPoint location = [(UITapGestureRecognizer *)sender locationInView:sender.view];
            CourtView *tempCourtView = (CourtView *)sender.view;
            double xPercent = location.x/(sender.view.frame.size.width);
            double yPercent = location.y/(sender.view.frame.size.height);
            xVal = xPercent;
            yVal = yPercent;
            [tempCourtView setX:xPercent andY:yPercent];
            
            SCRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            currentRally = [NSEntityDescription insertNewObjectForEntityForName:@"Rally" inManagedObjectContext:delegate.managedObjectContext];
            currentRally.xPosition = [NSNumber numberWithDouble:xPercent];
            currentRally.yPosition = [NSNumber numberWithDouble:yPercent];
            
            self.p1Stepper.value = p1Score;
            self.p2Stepper.value = p2Score;
            self.gameStepper.value = gameNumber;
            [self playerScoreChanged:nil];
            [self gameNumberChanged:nil];
            
            
            [UIView animateWithDuration:0.5 
                             animations:^{
                                 self.topOverlayView.frame = CGRectMake(0, 43, 320, 0);
                                 
                                 self.entryView.frame = entryViewFrameUp;
                                 sender.view.frame = imageFrameSmall;
                                 CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI/2.0);
                                 sender.view.transform = rotate;
                                 self.opaqueView.alpha = 0.5;
                                 
                             }
                             completion:^(BOOL finished){
                                 //Set Bool
                                 entryViewUp = true;
                                 [self.entryScrollView addSubview:sender.view];
                                 
                                 //Add Court View to Entry Scroll View
                                 [sender.view setFrame:CGRectMake(sender.view.frame.origin.x, sender.view.frame.origin.y-43, sender.view.frame.size.width, sender.view.frame.size.height)];
                                 sender.view.tag = 1024;
                                 
                                 
                             }];
        }
        
    }
}

- (void)saveShot {
    
}

- (IBAction)doneButtonPressed:(id)sender {
    entryViewUp = false;
    NSMutableArray *items = [NSMutableArray arrayWithArray:self.topToolbar.items];
    [items removeLastObject];
    [self.topToolbar setItems:items animated:YES];
    
   

    
    currentRally.p1Score = [NSNumber numberWithDouble:self.p1Stepper.value];
    currentRally.p2Score = [NSNumber numberWithDouble:self.p2Stepper.value];
    
        
    p1Score = self.p1Stepper.value;
    p2Score = self.p2Stepper.value;
    gameNumber = self.gameStepper.value;
    
    Rally *rally = [self addRallyWithGameNumber:gameNumber andPointNumber:(p1Score + p2Score)];
    rally.p1Score = [NSNumber numberWithInt:p1Score];
    rally.p2Score = [NSNumber numberWithInt:p2Score];
    rally.pointNumber = [NSNumber numberWithInt:p1Score+p2Score];
    rally.xPosition = [NSNumber numberWithDouble:xVal];
    rally.yPosition = [NSNumber numberWithDouble:yVal];
    rally.p1Finished = [NSNumber numberWithBool:(self.playerSegControl.selectedSegmentIndex == 0)];
    
    if (self.shotSegControlTop.selectedSegmentIndex > -1) {
        rally.finishingShot = [NSNumber numberWithInt:self.shotSegControlTop.selectedSegmentIndex];

    }
    else     
        rally.finishingShot = [NSNumber numberWithInt:(self.shotSegControlBottom.selectedSegmentIndex+3)];

    
    [UIView animateWithDuration:0.5 
                     animations:^{
                         self.entryView.frame = entryViewFrameDown;
                         self.opaqueView.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){
                         
                         if (self.p1Stepper.value == self.match.pointsPerGame.intValue || self.p2Stepper.value == self.match.pointsPerGame.intValue) {
                             self.p1Stepper.value = 0;
                             self.p2Stepper.value = 0;
                             self.gameStepper.value = self.gameStepper.value + 1;
                         }
                         
                         [self addNewCourtImage];
                         [[self.view viewWithTag:1024] removeFromSuperview];
                         entryViewUp = false;
                         
                         //scroll view
                         currentRally = NULL;
                         [self resetEntryView];
                         [self setCourtView];
                         
                         
                     }];
    
    [self saveShot];
    
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
                    self.p1Stepper.value++;
                }
                else self.p2Stepper.value++;
            }
            else if (self.shotSegControlTop.selectedSegmentIndex == kUnforcedError || self.shotSegControlTop.selectedSegmentIndex == kError) {
                if (self.playerSegControl.selectedSegmentIndex == 0) {
                    self.p2Stepper.value++;
                }
                else self.p1Stepper.value++;
            }

        }
        else {
            switch (self.shotSegControlBottom.selectedSegmentIndex + 3) {
                case kNoLet: {
                    if (self.playerSegControl.selectedSegmentIndex == 0) {
                        self.p2Stepper.value++;
                    }
                    else self.p1Stepper.value++;
                    break;
                }
                case kLet: {
                    if (self.playerSegControl.selectedSegmentIndex == 0) {
                        self.p2Stepper.value++;
                    }
                    else self.p1Stepper.value++;
                    break;
                }
                case kStroke: {
                    if (self.playerSegControl.selectedSegmentIndex == 0) {
                        self.p1Stepper.value++;
                    }
                    else self.p2Stepper.value++;
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
        // Remove match
        return;
    }
        Game *oldGame = (Game *)[(Rally *)[self.rallyArray objectAtIndex:0] game];
    Game *newGame;
    int counter = 0;
    int p1GameScoreint = 0;
    int p2GameScoreint = 0;
    for (int i = 0; i < self.rallyArray.count; i++) {
        Rally *tempRally = (Rally *)[self.rallyArray objectAtIndex:i];
        newGame = (Game *)tempRally.game;
        
        if (newGame.number.intValue != oldGame.number.intValue) {
            oldGame = newGame;
            oldGame.p1Score = [NSNumber numberWithInt:p1GameScoreint];
            oldGame.p2Score = [NSNumber numberWithInt:p2GameScoreint];
            counter = 0;
            
        }
        
        tempRally.pointNumber = [NSNumber numberWithInt:i];
        p1GameScoreint = tempRally.p1Score.intValue;
        p2GameScoreint = tempRally.p2Score.intValue;
        counter++;
    }
    
    oldGame.p1Score = [NSNumber numberWithInt:p1GameScoreint];
    oldGame.p2Score = [NSNumber numberWithInt:p2GameScoreint];

    if (p1GameScoreint > p2GameScoreint) {
        self.match.p1GameScore = [NSNumber numberWithInt:self.match.p1GameScore.intValue + 1];
    }
    
    if (p2GameScoreint > p1GameScoreint) {
        self.match.p2GameScore = [NSNumber numberWithInt:self.match.p2GameScore.intValue + 1];
    }
    
    
    
    int count = [self.navigationController.viewControllers count];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count-4] animated:YES];

}

-(void)finishButtonPressed {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Are You Sure You Want To End The Match" delegate:self cancelButtonTitle:@"No, Don't End Match" destructiveButtonTitle:@"Yes, End Match" otherButtonTitles:nil];
    [sheet showInView:self.view];

}


-(IBAction)playerScoreChanged:(id)sender {
    self.p1ScoreLabel.text = [NSString stringWithFormat:@"%u", (int)p1Stepper.value];
    self.p2ScoreLabel.text = [NSString stringWithFormat:@"%u", (int)p2Stepper.value];
    
    self.gameWonLabel.hidden = TRUE;
    
    if ((int)p1Stepper.value == self.match.pointsPerGame.intValue) {
        self.gameWonLabel.hidden = FALSE;
        self.gameWonLabel.text = [NSString stringWithFormat:@"%@ Wins Game %u", [self.match.player1 getName:kFullName], (int)self.gameStepper.value];
    }
    else if ((int)p2Stepper.value == self.match.pointsPerGame.intValue) {
        self.gameWonLabel.hidden = FALSE;
        self.gameWonLabel.text = [NSString stringWithFormat:@"%@ Wins Game %u", [self.match.player2 getName:kFullName], (int)self.gameStepper.value];
        
    }
    
}
-(IBAction)gameNumberChanged:(id)sender {
    self.gameNumberLabel.text = [NSString stringWithFormat:@"%u", (int)gameStepper.value];
    
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
    if (buttonIndex == 0) {
        [self endMatch];

    }
}




@end
