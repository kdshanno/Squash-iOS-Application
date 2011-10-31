//
//  PlayerProfileController.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerProfileController.h"

@implementation PlayerProfileController

@synthesize player;
@synthesize managedObjectContext = __managedObjectContext;

@synthesize firstNameLabel, lastNameLabel, playerPicture, recordLabel, winnersLabel, letsLabel, errorsLabel, lastgame1date, lastgame1label, lastgame2date, lastgame2label, lastgame3date, lastgame3label, scrollView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view addSubview:self.scrollView];
        [self.scrollView setFrame:CGRectMake(0, 44, 320, 480-44)];
        [self.scrollView setContentSize:CGSizeMake(320, 644)];
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

- (void)updateData {
    self.title = [self.player getName:kFullName];
    
    self.firstNameLabel.text = self.player.firstName;
    self.lastNameLabel.text = self.player.lastName;

}

- (void)editButtonPressed {
    PlayerProfileEditController *editController = [[PlayerProfileEditController alloc] initWithStyle:UITableViewStyleGrouped];
    editController.managedObjectContext = self.managedObjectContext;
    editController.player = self.player;
    editController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:editController];
    navController.navigationBar.tintColor = [UIColor redColor];
    [self.navigationController presentModalViewController:navController animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
    
    [self updateData];
   
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

#pragma mark - Player Edit Delegate


- (void)didChangeData {
    [self updateData];

}

@end
