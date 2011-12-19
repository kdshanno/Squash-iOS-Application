//
//  ShotEntryController.m
//  Squash Court Report
//
//  Created by Maxwell Shaw on 10/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShotEntryController.h"

@implementation ShotEntryController

@synthesize managedObjectContext, match, courtImage, toolbar, titleButton, entryView, playerSegmentedControl, entryScrollView, p1NameLabel, p1ScoreLabel, p2NameLabel, p2ScoreLabel, gameNumberLabel, p1Stepper, p2Stepper, gameStepper, p1ScoreNameLabel, p2ScoreNameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void)initEntryView {
    
    [self.toolbar setTintColor:[UIColor redColor]];
    [self.entryScrollView setContentSize:CGSizeMake(320, 800)];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(courtTapped:)];
    tapRecognizer.numberOfTapsRequired = 1;
    UIImageView *newCourt = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    newCourt.frame = imageFrameBig;
    newCourt.layer.zPosition = [[self.view.superview subviews] count]+5;
    [self.view addSubview:newCourt];
    [newCourt setUserInteractionEnabled:YES];
    [newCourt addGestureRecognizer:tapRecognizer];

    self.playerSegmentedControl.tintColor = [UIColor redColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    
   // [self.view addSubview:self.entryView];
    entryViewFrameDown = CGRectMake(0, self.view.frame.size.height+60, self.view.frame.size.width, self.entryView.frame.size.height);
    entryViewFrameUp = CGRectMake(0, -1, self.view.frame.size.width, self.entryView.frame.size.height);

    imageFrameBig = self.courtImage.frame;
    imageFrameSmall = CGRectMake(15, 60, 100, 140);
    entryViewUp = false;
    
    self.entryView.frame = entryViewFrameDown;
    
    [self initEntryView];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Entry Shot Actions
- (void)courtTapped:(UIGestureRecognizer *)sender {
    if (entryViewUp == false) {
        [sender.view setUserInteractionEnabled:NO];
        if (sender.state == UIGestureRecognizerStateEnded) {
            [UIView animateWithDuration:0.3 
                             animations:^{
                                 self.entryView.frame = entryViewFrameUp;
                                 sender.view.frame = imageFrameSmall;
                             }
                             completion:^(BOOL finished){
                                 NSLog(@"UP");
                                 entryViewUp = true;
                                 //[self.entryView addSubview:sender.view];
                                // [sender.view removeFromSuperview];
                             }];
        }

    }
}

- (void)doneButtonPressed {
    entryViewUp = false;
    
        [UIView animateWithDuration:0.3 
                         animations:^{
                             self.entryView.frame = entryViewFrameDown;
                         }
                         completion:^(BOOL finished){
                             [self.courtImage setUserInteractionEnabled:NO];
                             entryViewUp = false;
                         }];

}




-(IBAction)playerScoreChanged:(id)sender {
    self.p1ScoreLabel.text = [NSString stringWithFormat:@"%u", (int)p1Stepper.value];
    self.p2ScoreLabel.text = [NSString stringWithFormat:@"%u", (int)p2Stepper.value];

}
-(IBAction)gameNumberChanged:(id)sender {
    self.gameNumberLabel.text = [NSString stringWithFormat:@"%u", (int)gameStepper.value];

}


@end
