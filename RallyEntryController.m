//
//  RallyEntryController.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RallyEntryController.h"
#import "CourtView.h"

@implementation RallyEntryController

@synthesize managedObjectContext, match, courtImage, bottomToolbar, titleButton, entryView, playerSegmentedControl, entryScrollView, p1NameLabel, p1ScoreLabel, p2NameLabel, p2ScoreLabel, gameNumberLabel, p1Stepper, p2Stepper, gameStepper, p1ScoreNameLabel, p2ScoreNameLabel, topToolbar, opaqueView, playerSegControl, shotSegControl;

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

}
- (void)initEntryView {
    
    [self addNewCourtImage];
    
    [self.entryView addSubview:self.entryScrollView];
    [self.entryScrollView setContentSize:CGSizeMake(320, 602)];
    [self.entryScrollView setBackgroundColor:[UIColor clearColor]];
    [self.entryScrollView setFrame:CGRectMake(0, 0, self.entryView.frame.size.width, self.entryView.frame.size.height)];
    
    [self.playerSegControl setTintColor:[UIColor redColor]];
    [self.playerSegControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    
    [self.shotSegControl setTintColor:[UIColor redColor]];
    [self.shotSegControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.bottomToolbar setTintColor:[UIColor redColor]];
    [self.topToolbar setTintColor:[UIColor redColor]];

    
    [self.view setBackgroundColor:[UIColor colorWithRed:253.0/255.0 green:250.0/255.0 blue:212.0/255.0 alpha:1.0]];
    
    [self.view addSubview:self.entryView];
    entryViewFrameDown = CGRectMake(0, self.view.frame.size.height+60, self.view.frame.size.width, self.entryView.frame.size.height);
    entryViewFrameUp = CGRectMake(0, 43, self.view.frame.size.width, self.entryView.frame.size.height);
    
    imageFrameBig = self.courtImage.frame;
    imageFrameSmall = CGRectMake(90, 30, 139, 210);
    entryViewUp = false;
    
    self.entryView.frame = entryViewFrameDown;
    
    [self initEntryView];
    
    [self.topToolbar setItems:[NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc] initWithTitle:@"Finish" style:UIBarButtonItemStyleBordered target:self action:@selector(finishButtonPressed)],
                               [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] , nil]];
    
    // Do any additional setup after loading the view from its nib.
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
            CourtView *courtView = (CourtView *)sender.view;
            [courtView setX:location.x/(sender.view.frame.size.width) andY:location.y/(sender.view.frame.size.height)];
 
            [UIView animateWithDuration:0.5 
                             animations:^{
                                 self.entryView.frame = entryViewFrameUp;
                                 sender.view.frame = imageFrameSmall;
                                 CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI/2.0);
                                 CGAffineTransform scale = CGAffineTransformMakeScale(0.5, 0.5);
                                 sender.view.transform = rotate;
                                 //sender.view.transform = CGAffineTransformConcat(rotate, scale);
                                 self.opaqueView.alpha = 0.5;
                             }
                             completion:^(BOOL finished){
                                 //Set Bool
                                 entryViewUp = true;
                                 [self.entryScrollView addSubview:sender.view];
                                 
                                 //Add Court View to Entry Scroll View
                                 [sender.view setFrame:CGRectMake(sender.view.frame.origin.x, sender.view.frame.origin.y-43, sender.view.frame.size.width, sender.view.frame.size.height)];
                                 sender.view.tag = 1024;
                                 
                                 // Set Top Bar
                                 NSArray *items = self.topToolbar.items;
                                 [self.topToolbar setItems:[items arrayByAddingObject:[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonPressed:)]] animated:YES];
                             }];
        }
        
    }
}

- (IBAction)doneButtonPressed:(id)sender {
    entryViewUp = false;
    NSMutableArray *items = [NSMutableArray arrayWithArray:self.topToolbar.items];
    [items removeLastObject];
    [self.topToolbar setItems:items animated:YES];
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
                         [self.entryScrollView setContentOffset:CGPointMake(0, 0)];
                         
                     }];
    
}

-(IBAction)playerSegChanged:(id)sender {
    
}

-(IBAction)shotSegChanged:(id)sender {
    
}


-(void)finishButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)playerScoreChanged:(id)sender {
    self.p1ScoreLabel.text = [NSString stringWithFormat:@"%u", (int)p1Stepper.value];
    self.p2ScoreLabel.text = [NSString stringWithFormat:@"%u", (int)p2Stepper.value];
    
}
-(IBAction)gameNumberChanged:(id)sender {
    self.gameNumberLabel.text = [NSString stringWithFormat:@"%u", (int)gameStepper.value];
    
}


@end
