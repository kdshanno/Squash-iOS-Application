//
//  MatchProfileViewController.m
//  Squash Court Report
//
//  Created by Rishi Narang on 10/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MatchProfileViewController.h"

@implementation MatchProfileViewController

@synthesize player1Label, player2Label, tournamentMatchSwitch, gameTypeSwitch, dateLabel, buildingField, cityField, stateField, countryField, conditionField, tournamentNameField, roundField, notesTextView, match, p1, p2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil player1:(Player *)player1 player2:(Player *)player2
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Match Profile", "Match Profile");
        [self setP1:player1];
        [self setP2:player2];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.player1Label setText:[NSString stringWithFormat:@"%@ %@", p1.firstName, p1.lastName]];
    [self.player2Label setText:[NSString stringWithFormat:@"%@ %@", p2.firstName, p2.lastName]];
    
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

#pragma mark - UI interaction

- (IBAction)dateButtonPressed
{
    
}

@end
