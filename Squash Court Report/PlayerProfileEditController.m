//
//  PlayerProfileController.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerProfileEditController.h"
#import "TextFieldCell.h"

@implementation PlayerProfileEditController

@synthesize player, delegate;
@synthesize managedObjectContext = __managedObjectContext;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        //if (self.title == nil) self.title = [self.player getFullName];
        [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Wood_Background.png"]]];

    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style andPlayer:(Player *)editingPlayer
{
    self = [super initWithStyle:style];
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

- (void)saveNewPlayer {
    
    if(firstNameField.text == NULL || lastNameField.text == NULL || [firstNameField.text compare:@""] == NSOrderedSame || [lastNameField.text compare:@""] == NSOrderedSame)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must enter a first and last name." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
        [alert show];
        return;
    }
    
    Player *newPlayer;
    if (self.player == nil) {
        newPlayer = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.managedObjectContext];
        
    }
    else newPlayer = self.player;
        

    newPlayer.firstName = firstNameField.text;
    newPlayer.lastName = lastNameField.text;
    newPlayer.style = playerStyle.text;
    newPlayer.city = city.text;
    newPlayer.stateProvince = stateProvince.text;
    newPlayer.country = country.text;
    newPlayer.headCoach = headCoach.text;
    newPlayer.homeClub = homeClub.text;
    
    [newPlayer setHanded:[handednessSegControl selectedSegmentIndex]];


    [self.delegate didChangeData];
    [self.parentViewController dismissModalViewControllerAnimated:YES];
    
}

- (void)cancel {
    [self.parentViewController dismissModalViewControllerAnimated:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveNewPlayer)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
       self.title = @"Edit Player";
    
    cellDictionary = [[NSMutableDictionary alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 5;
            break;
            
        default:
            break;
    };
    return 0;
}

- (TextFieldCell *)createCellatIndexPath:(NSIndexPath *)indexPath {
    TextFieldCell *cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textField.delegate = self;
    
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    cell.identifierLabel.text = @"First Name";
                    cell.textField.placeholder = @"Required";
                    if (self.player != nil) {
                        cell.textField.text = self.player.firstName;
                    }
                    firstNameField = cell.textField;
                    break;
                }
                    
                case 1: {
                    cell.identifierLabel.text = @"Last Name";
                    cell.textField.placeholder = @"Required";
                    
                    if (self.player != nil) {
                        cell.textField.text = self.player.lastName;
                        
                    }
                    lastNameField = cell.textField;
                    
                    break;
                }
                    
                case 2: {
                    cell.identifierLabel.text = @"Style";
                    if (self.player != nil) {
                        cell.textField.text = self.player.style;
                    }
                    playerStyle = cell.textField;
                    
                    break;
                }
                    
                default:
                    break;
            }   
            
            break;
        }
            
        case 1: {
            UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Left-Handed", @"Right-Handed", nil]];
            segControl.frame = CGRectMake(0, 0, 300, cell.contentView.frame.size.height+5) ;
            [segControl setSegmentedControlStyle:UISegmentedControlStyleBar];
            [segControl setTintColor:[UIColor redColor]];
            
            handednessSegControl = segControl;
            if (self.player) {
                [segControl setSelectedSegmentIndex:[self.player getHanded]];

            }
            
            [cell.contentView addSubview:segControl];
            
            break;
        }
            
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    cell.identifierLabel.text = @"City";
                    if (self.player != nil) {
                        cell.textField.text = self.player.city;
                    }
                    city = cell.textField;
                    
                    break;
                }
                case 1: {
                    cell.identifierLabel.text = @"State / Province";
                    
                    if (self.player != nil) {
                        cell.textField.text = self.player.stateProvince;
                    }
                    stateProvince = cell.textField;
                    break;
                }
                    
                case 2: {
                    cell.identifierLabel.text = @"Country";
                    if (self.player != nil) {
                        cell.textField.text = self.player.country;
                    }
                    country = cell.textField;
                    
                    break;
                }
                case 3: {
                    cell.identifierLabel.text = @"Home Club";
                    if (self.player != nil) {
                        cell.textField.text = self.player.homeClub;
                    }
                    homeClub = cell.textField;
                    
                    break;
                }
                    
                case 4: {
                    cell.identifierLabel.text = @"Head Coach";
                    
                    if (self.player != nil) {
                        cell.textField.text = self.player.headCoach;
                    }
                    headCoach = cell.textField;
                    break;
                }
                    
                    
                default:
                    break;
            }
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"id_%d_%d", indexPath.section, indexPath.row];
    
    TextFieldCell *cell;
    
    if ([cellDictionary objectForKey:cellID]) {
        cell = (TextFieldCell *)[cellDictionary objectForKey:cellID];
    }
    else {
        cell = [self createCellatIndexPath:indexPath];
        [cellDictionary setObject:cell forKey:cellID];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"id_%d_%d", indexPath.section, indexPath.row];

    TextFieldCell *selectedCell = (TextFieldCell *)[cellDictionary objectForKey:cellID];
    [selectedCell.textField becomeFirstResponder];
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

@end
