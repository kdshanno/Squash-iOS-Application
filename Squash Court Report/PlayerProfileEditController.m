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

@synthesize firstNameField, lastNameField, player, delegate, playerStyle, city, stateProvince, country, homeClub, headCoach;
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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)saveNewPlayer {
    
    if(self.firstNameField.text == NULL || self.lastNameField.text == NULL || [self.firstNameField.text compare:@""] == NSOrderedSame || [self.lastNameField.text compare:@""] == NSOrderedSame)
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
        

    newPlayer.firstName = self.firstNameField.text;
    newPlayer.lastName = self.lastNameField.text;

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    TextFieldCell *cell = (TextFieldCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    cell.identifierLabel.text = @"First Name";
                    self.firstNameField = cell.textField;
                    if (self.player != nil) {
                        self.firstNameField.text = self.player.firstName;
                    }
                    break;
                }
                case 1: {
                    cell.identifierLabel.text = @"Last Name";
                    self.lastNameField = cell.textField;
                    if (self.player != nil) {
                        self.lastNameField.text = self.player.lastName;
                    }
                    break;
                }
                case 2: {
                    cell.identifierLabel.text = @"Style";
                    self.playerStyle = cell.textField;
                    if (self.player != nil) {
                        self.playerStyle.text = self.player.firstName;
                    }
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
            [cell.contentView addSubview:segControl];
            
            break;
        }
            
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    cell.identifierLabel.text = @"City";
                    self.city = cell.textField;
                    if (self.player != nil) {
                        self.city.text = self.player.lastName;
                    }
                    break;
                }
                case 1: {
                    cell.identifierLabel.text = @"State / Province";
                    self.stateProvince = cell.textField;
                    if (self.player != nil) {
                        self.stateProvince.text = self.player.lastName;
                    }
                    break;
                }
                    
                case 2: {
                    cell.identifierLabel.text = @"Country";
                    self.country = cell.textField;
                    if (self.player != nil) {
                        self.country.text = self.player.lastName;
                    }
                    break;
                }
                case 3: {
                    cell.identifierLabel.text = @"Home Club";
                    self.homeClub = cell.textField;
                    if (self.player != nil) {
                        self.homeClub.text = self.player.lastName;
                    }
                    break;
                }
                    
                case 4: {
                    cell.identifierLabel.text = @"Head Coach";
                    self.headCoach = cell.textField;
                    if (self.player != nil) {
                        self.lastNameField.text = self.player.lastName;
                    }
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
