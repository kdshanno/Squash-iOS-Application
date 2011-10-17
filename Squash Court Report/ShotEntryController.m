//
//  ShotEntryController.m
//  Squash Court Report
//
//  Created by Maxwell Shaw on 10/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShotEntryController.h"

@implementation ShotEntryController

@synthesize managedObjectContext, match, courtImage, toolbar, titleButton, entryView, playerSegmentedControl;

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

-(IBAction)animateImage:(id)sender {
    [UIView animateWithDuration:0.6f delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^(void) {
        [self.courtImage setFrame:CGRectMake(40, 40, 100, 100)];
    }completion:NULL];
}

#pragma mark - View lifecycle

- (void)initEntryView {
    //[self.entryView setFrame:CGRectMake(0, 100, self.entryView.frame.size.width, self.entryView.frame.size.height)];

    [self.view addSubview:self.entryView];
    
    [self.toolbar setTintColor:[UIColor redColor]];

    //[self.playerSegmentedControl setTintColor:[UIColor redColor]];
    self.playerSegmentedControl.tintColor = [UIColor redColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self initEntryView];
    
    [self.view addSubview:self.entryView];
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

@end
