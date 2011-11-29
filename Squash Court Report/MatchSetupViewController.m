//
//  MatchSetupViewController.m
//  Squash Court Report
//
//  Created by Rishi Narang on 10/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MatchSetupViewController.h"
#import "SCRAppDelegate.h"
#import "PlayerEditController.h"
#import "MatchProfileViewController.h"

@implementation MatchSetupViewController

@synthesize player1Label, player2Label, players, player1Index, player2Index, picker, selectionButton, playerBeingEdited, matchProfileButton;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"Match Setup", @"Match Setup");
    
    // Store the player list ahead of time
    players = [[NSMutableArray alloc] init];
    
    SCRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [appDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, sortDescriptor2, nil]];
    
    NSError *error;
    NSArray *array = [NSMutableArray arrayWithArray:[moc executeFetchRequest:request error:&error]];
    
    
    for (int i=0; i<array.count; i++) 
    {     
        Player *player = [array objectAtIndex:i];
        
        [players addObject:player];
        
    }
    
    player1Index = -1;
    player2Index = -1;
    
    picker = [[AnimatedUIPickerView alloc] init];
    picker.showsSelectionIndicator = YES;
    picker.dataSource = self;
    picker.delegate = self;
    [picker addToView:self.view];
    [selectionButton setHidden:YES];
    
    playerBeingEdited = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(playerBeingEdited == 0)
        return;
    
    // code for handling a closed modal view controller
    // reload the data
    
    SCRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [appDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, sortDescriptor2, nil]];
    
    NSError *error;
    NSArray *newPlayers =[moc executeFetchRequest:request error:&error];
    
    int i = 0;
    BOOL playerAdded = (players.count != newPlayers.count);
    for(; i < players.count; i++)
    {
        if([players objectAtIndex:i] != [newPlayers objectAtIndex:i])
            break;
    }
    
    //in newPlayers, index i is the new element.
    
    if (playerAdded)
    {
        
        [players insertObject:[newPlayers objectAtIndex:i] atIndex:i];
        [picker reloadAllComponents];
        
        if(playerBeingEdited == 1)
        {
            player1Index = i;
            [player1Label setText:[self pickerView:picker titleForRow:i forComponent:0]];
            
            if(player2Index >= i) //the index of the other player has shifted
                player2Index++;
            
        }
        else if(playerBeingEdited == 2)
        {
            player2Index = i;
            [player2Label setText:[self pickerView:picker titleForRow:i forComponent:0]];
            
            if(player1Index >= i) //the index of the other player has shifted
                player1Index++;
        }
        else
        {
            NSLog(@"error!"); 
            abort();
        }
        
        [picker enterSuperviewAnimatedWithRow:i];
        [selectionButton setHidden:NO];
    }
    
    playerBeingEdited = 0;
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

#pragma mark - Interface controls

-(IBAction)player1Dropdown 
{
    picker.tag = 1;
    if(picker.hidden)
    {
        if(player1Index > -1)
            [picker enterSuperviewAnimatedWithRow:player1Index];
        else  
            [picker enterSuperviewAnimatedWithRow:0];
        
        [selectionButton setHidden:NO];
    }
    else
    {
        if(player1Index > -1)
        {
            [self pickerView:picker didSelectRow:player1Index inComponent:0]; 
            [picker selectRow:player1Index inComponent:0 animated:YES];    
        }
        else  
        {
            [self pickerView:picker didSelectRow:0 inComponent:0]; 
            [picker selectRow:0 inComponent:0 animated:YES];
        }
    }
}

-(IBAction)player2Dropdown
{
    picker.tag = 2;
    if(picker.hidden)
    {
        if(player2Index > -1)
            [picker enterSuperviewAnimatedWithRow:player2Index];
        else  
            [picker enterSuperviewAnimatedWithRow:0];
        
        [selectionButton setHidden:NO];
    }
    else
    {
        if(player2Index > -1)
        {
            [self pickerView:picker didSelectRow:player2Index inComponent:0]; 
            [picker selectRow:player2Index inComponent:0 animated:YES];    
        }
        else  
        {
            [self pickerView:picker didSelectRow:0 inComponent:0]; 
            [picker selectRow:0 inComponent:0 animated:YES];
        }
    }
}

-(IBAction)newPlayer1
{
    [self finishSelection];
    
    PlayerEditController *editController = [[PlayerEditController alloc] initWithStyle:UITableViewStyleGrouped andPlayer:NULL];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:editController];
    navController.navigationBar.tintColor = [UIColor redColor];
    playerBeingEdited = 1;
    [self.navigationController presentModalViewController:navController animated:YES];
}

-(IBAction)newPlayer2
{
    [self finishSelection];
    
    PlayerEditController *editController = [[PlayerEditController alloc] initWithStyle:UITableViewStyleGrouped andPlayer:NULL];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:editController];
    navController.navigationBar.tintColor = [UIColor redColor];
    playerBeingEdited = 2;
    [self.navigationController presentModalViewController:navController animated:YES];
}

-(IBAction)finishSelection
{
    [picker exitSuperviewAnimated];
    [selectionButton setHidden:YES];
    picker.tag = 0;
}

- (IBAction)setupMatchProfile
{
    MatchProfileViewController *mpvc = [[MatchProfileViewController alloc] initWithNibName:@"MatchProfileView" bundle:nil player1:(Player *)[players objectAtIndex:player1Index] player2:(Player *)[players objectAtIndex:player2Index]];
    [self.navigationController pushViewController:mpvc animated:YES];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return players.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@ %@", ((Player *)[players objectAtIndex:row]).firstName, ((Player *)[players objectAtIndex:row]).lastName];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(row >= players.count)
        return;
    
    switch (pickerView.tag) {
        case 1:
        {
            [player1Label setText:[self pickerView:pickerView titleForRow:row forComponent:component]];
            player1Index = row;
            break;
        }
            
        case 2:
        {
            [player2Label setText:[self pickerView:pickerView titleForRow:row forComponent:component]];
            player2Index = row;
            break;
        }
            
        default:
            break;
    }
    
    if(player1Index == -1 || player2Index == -1 || player1Index == player2Index)
        matchProfileButton.hidden = YES;
    else
        [matchProfileButton setHidden:NO];
}


@end
