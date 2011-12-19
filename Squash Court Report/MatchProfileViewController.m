//
//  MatchProfileViewController.m
//  Squash Court Report
//
//  Created by Rishi Narang on 10/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MatchProfileViewController.h"
#import "RallyEntryController.h"
#import "Match.h"
#import "SCRAppDelegate.h"

@implementation MatchProfileViewController

@synthesize scroll, player1Label, player2Label, tournamentMatchSwitch, gameTypeSwitch, dateLabel, buildingField, cityField, stateField, countryField, conditionField, tournamentNameField, roundField, notesTextView, datePicker, p1, p2, doneSelectingDateButton, pointsPerGameSwitch;

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
    [scroll setContentSize:CGSizeMake(self.view.frame.size.width, 490)];
    [self.player1Label setText:[NSString stringWithFormat:@"%@ %@", p1.firstName, p1.lastName]];
    [self.player2Label setText:[NSString stringWithFormat:@"%@ %@", p2.firstName, p2.lastName]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneCreatingProfile)];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM/dd/yyyy"];
	NSString *dateString = [formatter stringFromDate:[NSDate date]];
    [dateLabel setText:dateString];
    
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
    if(datePicker == nil)
    {
        datePicker = [[AnimatedUIDatePicker alloc] init];
        [datePicker addToView:self.view];
        [datePicker setDatePickerMode:UIDatePickerModeDate];
        [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    }
    
    if(datePicker.isHidden)
    {
        [datePicker enterSuperviewAnimated];
        [doneSelectingDateButton setHidden:NO];
    }
    else
    {
        [datePicker exitSuperviewAnimated];
        [doneSelectingDateButton setHidden:YES];
    }
}

- (IBAction)doneSelectingDate
{
    [datePicker exitSuperviewAnimated];
    [doneSelectingDateButton setHidden:YES];
}

- (void)dateChanged
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM/dd/yyyy"];
	NSString *dateString = [formatter stringFromDate:[datePicker date]];
    [dateLabel setText:dateString];
}

- (void)doneCreatingProfile
{
    SCRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [appDelegate managedObjectContext];
    Match *currentMatch = [NSEntityDescription insertNewObjectForEntityForName:@"Match" inManagedObjectContext:moc];

    [currentMatch setNumberOfGames:[NSNumber numberWithInt:0]];
    [currentMatch setP1GameScore:[NSNumber numberWithInt:0]];
    [currentMatch setP2GameScore:[NSNumber numberWithInt:0]];
    
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM/dd/yyyy"];
	NSDate *date = [formatter dateFromString:self.dateLabel.text];	
    [currentMatch setDatePlayed:date];
    
    [currentMatch setPlayer1:p1];
    [currentMatch setPlayer2:p2];
    [currentMatch setGames:[NSSet set]];
    [currentMatch setCity:cityField.text];
    [currentMatch setComplex:buildingField.text];
    [currentMatch setCountry:countryField.text];
    [currentMatch setCourtCondition:conditionField.text];
    [currentMatch setDrawRound:roundField.text];
    [currentMatch setNotes:notesTextView.text];
    [currentMatch setProvinceState:stateField.text];
    [currentMatch setTournamentName:tournamentNameField.text];
    
    if(tournamentMatchSwitch.selectedSegmentIndex == 0)
        [currentMatch setMatchType:[NSNumber numberWithInt:kPractice]];
    else
        [currentMatch setMatchType:[NSNumber numberWithInt:kTournament]];
    
    if(gameTypeSwitch.selectedSegmentIndex == 0)
        [currentMatch setRecordingType:[NSNumber numberWithInt:kLive]];
    else
        [currentMatch setRecordingType:[NSNumber numberWithInt:kFilm]];
    
    if(pointsPerGameSwitch.selectedSegmentIndex == 0)
        [currentMatch setPointsPerGame:[NSNumber numberWithInt:11]];
    else
        [currentMatch setPointsPerGame:[NSNumber numberWithInt:15]];
    
    RallyEntryController *vc = [[RallyEntryController alloc] initWithMatch:currentMatch];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITextFieldDelegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    int keyboardHeight = 180;
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0);
    scroll.contentInset = contentInsets;
    scroll.scrollIndicatorInsets = contentInsets;
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardHeight;
    if (!CGRectContainsPoint(aRect, textField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, textField.frame.origin.y - (keyboardHeight - 15));
        [scroll setContentOffset:scrollPoint animated:YES];
    }
   // [scroll setContentSize:CGSizeMake(self.view.frame.size.width, 700)];
    //[scroll scrollRectToVisible:CGRectMake(0, textField.frame.origin.y - 190, 320, 460) animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scroll.contentInset = contentInsets;
    scroll.scrollIndicatorInsets = contentInsets;
    //[scroll setContentSize:CGSizeMake(self.view.frame.size.width, 490)];
    [textField resignFirstResponder];
    
    return YES;
}

/*
#pragma mark - UITextViewDelegate Methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //[scroll setContentSize:CGSizeMake(self.view.frame.size.width, 505)];
    [scroll scrollRectToVisible:CGRectMake(0, textView.frame.origin.y, 320, textView.frame.origin.y + 200) animated:YES];
}*/


@end
