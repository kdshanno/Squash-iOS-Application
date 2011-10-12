//
//  MainViewController.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewCell.h"
#import "PlayersViewController.h"

@implementation MainViewController

@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Court Report", @"Court Report");
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    /*
    Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.managedObjectContext];
    player.firstName = @"Kelly";
    player.lastName = @"Shannon";
    player.dateBorn = [NSDate date];
    player.handedness = [NSNumber numberWithInt:kLeftHanded];
    
    [self.managedObjectContext save:nil];
    */
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MainViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0: {
            cell.mainLabel.text = @"Log New Match";
            [cell.leftImageView setImage:[UIImage imageNamed:@"Person_Icon"]];

            break;
        }
        case 1: {
            cell.mainLabel.text = @"Players";
            [cell.leftImageView setImage:[UIImage imageNamed:@"Person_Icon"]];
            break;
        }

        case 2: {
            cell.mainLabel.text = @"Matches";
            [cell.leftImageView setImage:[UIImage imageNamed:@"Raquet_Icon"]];

            break;
        }

        case 3: {
            cell.mainLabel.text = @"Options";
            [cell.leftImageView setImage:[UIImage imageNamed:@"Person_Icon"]];


            break;
        }

            
        default:
            break;
    }
    
    // Configure the cell...
    
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
    switch (indexPath.row) {
        
        case 1: {
            PlayersViewController *playersViewController = [[PlayersViewController alloc] initWithStyle:UITableViewStylePlain];
            playersViewController.managedObjectContext = self.managedObjectContext;
            [self.navigationController pushViewController:playersViewController animated:YES];
    
            break;
        }
            
        default:
            break;
    }
    

    
    
}

@end
