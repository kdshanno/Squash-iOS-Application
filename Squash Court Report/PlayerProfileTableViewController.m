//
//  PlayerProfileTableViewController.m
//  Squash Court Report
//
//  Created by Maxwell Shaw on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerProfileTableViewController.h"
#import "PlayerProfileCell.h"
#import "PlayerProfileTopCell.h"
#import "MatchOverviewController.h"
#import "MatchListController.h"


@implementation PlayerProfileTableViewController

@synthesize player, managedObjectContext, sectionHeaderView;

-(void)setUpBioLabels {
    bioLeftLabels = [[NSMutableArray alloc] initWithCapacity:0];
    bioRightLabels = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    if (self.player.style != @"" && self.player.style) {
        [bioLeftLabels addObject:@"Style:"];
        [bioRightLabels addObject:self.player.style];
    }
    
    if (self.player.handedness) {
        if ([self.player getHanded] == kLeftHanded) {
            [bioLeftLabels addObject:@"Handedness:"];
            [bioRightLabels addObject:@"Left Handed"];
        }
        else if ([self.player getHanded] == kRightHanded) {
            [bioLeftLabels addObject:@"Handedness:"];
            [bioRightLabels addObject:@"Right Handed"];
        }
        
    }
    if (self.player.city != @"" && self.player.city) {
        [bioLeftLabels addObject:@"City:"];
        [bioRightLabels addObject:self.player.city];
    }
    if (self.player.stateProvince != @"" && self.player.stateProvince) {
        [bioLeftLabels addObject:@"State/Province:"];
        [bioRightLabels addObject:self.player.stateProvince];
    }
    if (self.player.country != @"" && self.player.country) {
        [bioLeftLabels addObject:@"Country:"];
        [bioRightLabels addObject:self.player.country];
    }
    if (self.player.headCoach != @"" && self.player.headCoach) {
        [bioLeftLabels addObject:@"Head Coach:"];
        [bioRightLabels addObject:self.player.headCoach];
    }
    if (self.player.homeClub != @"" && self.player.homeClub) {
        [bioLeftLabels addObject:@"Home Club:"];
        [bioRightLabels addObject:self.player.homeClub];
    }

    if (bioLeftLabels.count == 0) {
        [bioLeftLabels addObject:@"No Information, Click Edit To Add"];
        [bioRightLabels addObject:@""];
    }
}

-(void)setUpStatLabels {
    statsLeftLabels = [[NSMutableArray alloc] initWithCapacity:0];
    statsRightLabels = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([self.player getNumberOfMatches] == 0) {
        [statsLeftLabels addObject:@"No Matches Played"];
        [statsRightLabels addObject:@""];

        return;
    }
    
    if (true) {
        [statsLeftLabels addObject:@"Number Of Matches:"];
        [statsRightLabels addObject:[NSString stringWithFormat:@"%u", [self.player getNumberOfMatches]]];
    }
//    if (true) {
//        [statsLeftLabels addObject:@"Number of Wins:"];
//        [statsRightLabels addObject:[NSString stringWithFormat:@"%u", [self.player getNumberOfWins]]];
//    }
//    if (true) {
//        [statsLeftLabels addObject:@"Number Of Losses:"];
//        [statsRightLabels addObject:[NSString stringWithFormat:@"%u", [self.player getNumberOfLosses]]];
//    }
    
    if (true) {
        [statsLeftLabels addObject:@"Winners per Match:"];
        [statsRightLabels addObject:[NSString stringWithFormat:@"%u", [self.player getNumberofWinnersPerMatch]]];
    }
    
    if (true) {
        [statsLeftLabels addObject:@"Errors per Match:"];
        [statsRightLabels addObject:[NSString stringWithFormat:@"%u", [self.player getNumberofErrorsPerMatch]]];
    }
    
    [statsLeftLabels addObject:@"See All Stats"];
    [statsRightLabels addObject:@""];

}

-(void)setUpMatchesLabels {
    recentMatchesLeftLabels = [[NSMutableArray alloc] initWithCapacity:0];
    recentMatchesRightLabels = [[NSMutableArray alloc] initWithCapacity:0];

    if ([self.player getNumberOfMatches] == 0) {
        [recentMatchesLeftLabels addObject:@"No Matches Played"];
        return;
    }

    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"datePlayed" ascending:NO];
    recentMatches = [self.player.matches sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];

    
    int i = 0;
    for (Match *match in recentMatches) {
        if (i == 3) break;
        if (match.player1 == self.player) {
            if (match.winner == self.player) {
                [recentMatchesLeftLabels addObject:[NSString stringWithFormat:@"W  %u - %u against %@", match.p1GameScore.intValue, match.p2GameScore.intValue, [match.player2 getName:kFirstInitialLastName]]];
            }
            else if (match.loser == self.player)
                [recentMatchesLeftLabels addObject:[NSString stringWithFormat:@"L  %u - %u to %@", match.p1GameScore.intValue, match.p2GameScore.intValue, [match.player2 getName:kFirstInitialLastName]]];
            
            else [recentMatchesLeftLabels addObject:[NSString stringWithFormat:@"T  %u - %u with %@", match.p2GameScore.intValue, match.p1GameScore.intValue, [match.player2 getName:kFirstInitialLastName]]];

                  
        }
        else {
            if (match.winner == self.player) {
                [recentMatchesLeftLabels addObject:[NSString stringWithFormat:@"W  %u - %u against %@", match.p2GameScore.intValue, match.p1GameScore.intValue, [match.player1 getName:kFirstInitialLastName]]];
            }
            else if (match.loser == self.player) [recentMatchesLeftLabels addObject:[NSString stringWithFormat:@"L  %u - %u to %@", match.p2GameScore.intValue, match.p1GameScore.intValue, [match.player1 getName:kFirstInitialLastName]]];
            
            else [recentMatchesLeftLabels addObject:[NSString stringWithFormat:@"T  %u - %u with %@", match.p2GameScore.intValue, match.p1GameScore.intValue, [match.player1 getName:kFirstInitialLastName]]];
        }
        
        
        i++;
    }
    
    [recentMatchesLeftLabels addObject:@"See All Matches"];
}

- (void)initializeCellArrays 
{
    [self setUpBioLabels];
    [self setUpStatLabels];
    [self setUpMatchesLabels];


}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Wood_Background.png"]]];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        // Custom initialization
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style andPlayer:(Player *)newPlayer
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Wood_Background.png"]]];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.player = newPlayer;
        [self initializeCellArrays];
        
        sectionCollapse = [[NSMutableArray alloc] initWithCapacity:5];
        for (int i = 0; i < 5; i++) {
            [sectionCollapse addObject:[NSNumber numberWithBool:NO]];
        }


        self.title = [self.player getName:kFullName];
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

- (void)editButtonPressed 
{
    PlayerEditController *editController = [[PlayerEditController alloc] initWithStyle:UITableViewStyleGrouped andPlayer:self.player];
    editController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:editController];
    navController.navigationBar.tintColor = [UIColor redColor];
    [self.navigationController presentModalViewController:navController animated:YES];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
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
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int numberOfRows = 0;
    
    // Return 0 if collapsed
    if ([[sectionCollapse objectAtIndex:section] boolValue] == YES) {
        return 0;
    }
    switch (section) {
        case 0:
            numberOfRows = 1;
            break;
        case 1:
            numberOfRows = [bioLeftLabels count];

            break;

        case 2:
            numberOfRows = [recentMatchesLeftLabels count];
            break;
        case 3:
            numberOfRows = [statsLeftLabels count];

            break;
        case 4:
            numberOfRows = 1;
        default:
            break;
    }
    return numberOfRows;
    
}

- (void)addImageOnCell:(PlayerProfileTopCell *)cell {
  //  cell.leftImage.image = [self.player getImage];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"TopCell";

        PlayerProfileTopCell *cell = (PlayerProfileTopCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[PlayerProfileTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.topLabel.text = self.player.firstName;
        cell.bottomLabel.text = self.player.lastName;
        cell.detailLabel.text = [NSString stringWithFormat:@"%u - %u", [self.player getNumberOfWins], [self.player getNumberOfLosses]];
        cell.leftImage.image = self.player.image;
        
       // if (player.imageData) {
           // [self performSelectorOnMainThread:@selector(addImageOnCell:) withObject:cell waitUntilDone:NO];

      //  }

        return cell;
        

    }
    else if (indexPath.section == self.tableView.numberOfSections-1) {
        static NSString *CellIdentifier = @"bottomCell";

        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PlayerProfileLastFooter.png"]];
        return cell;
    }
    else {
        static NSString *CellIdentifier = @"Cell";

        PlayerProfileCell *cell = [[PlayerProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        
        switch (indexPath.section) {
            case 1: {
                cell.leftLabel.text = [bioLeftLabels objectAtIndex:indexPath.row];
                cell.rightLabel.text = [bioRightLabels objectAtIndex:indexPath.row];
                break;
            }
                
            case 2: {

                cell.leftLabel.text = [recentMatchesLeftLabels objectAtIndex:indexPath.row];
                if (recentMatchesLeftLabels.count > 1) {
                    cell.showDisclosure = TRUE;

                }
                break;
            }

                
            case 3: {
                cell.leftLabel.text = [statsLeftLabels objectAtIndex:indexPath.row];
                cell.rightLabel.text = [statsRightLabels objectAtIndex:indexPath.row];
                if (indexPath.row == statsLeftLabels.count-1 && statsLeftLabels.count > 1) {
                    cell.showDisclosure = TRUE;
                }
                break;
            }
            default:
                break;
        }
        
        return cell;

    }
    
    
    // Configure the cell...
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {    
    if (section == 0 || section == self.tableView.numberOfSections-1) {
        return NULL;
    }
    else if (section == 1) {
        SectionHeaderView *header = [[SectionHeaderView alloc] init];
        header.label.text = @"Bio";
        header.sectionNumber = section;
        header.delegate = self;


        return header;


    }
    else if (section == 2) {
        SectionHeaderView *header = [[SectionHeaderView alloc] init];
        header.label.text = @"Recent Matches";
        header.sectionNumber = section;
        header.delegate = self;

        return header;
        
        
    }

    else if (section == 3) {
        SectionHeaderView *header = [[SectionHeaderView alloc] init];
        header.label.text = @"Stats";
        header.sectionNumber = section;
        header.delegate = self;

        return header;
    }
    else return NULL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {    
    if (section == 0 || section == self.tableView.numberOfSections-1) {
        return 0;
    }
    else return 22;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kPlayerTopCellHeight;
    }
    else if (indexPath.section == self.tableView.numberOfSections-1) {
        return 17;
    }
    return PLAYERCELLHEIGHT;
    
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
    if (indexPath.section == 2) {
        if (indexPath.row == 3 || indexPath.row == recentMatches.count) {
            MatchListController *controller = [[MatchListController alloc] initWithPlayer:self.player];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else {
            MatchOverviewController *controller = [[MatchOverviewController alloc] initWithNibName:@"MatchOverviewController" bundle:nil match:[recentMatches objectAtIndex:indexPath.row]];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

#pragma mark - Edit Controller Degegate

- (void)didChangeData {
    [self initializeCellArrays];
    [self.tableView reloadData];    
}


#pragma mark - Section Degegate
- (void)sectionHeadedWasClicked:(SectionHeaderView *) sectionHeader{
    
    int number = sectionHeader.sectionNumber;
    
    BOOL previous = [[sectionCollapse objectAtIndex:number] boolValue];
    BOOL new = !previous;
    [sectionCollapse replaceObjectAtIndex:number withObject:[NSNumber numberWithBool:new]];
    int count;
    
    switch (number) {
        case 1:
            count = bioLeftLabels.count;
            break;
        case 2 :
            count = recentMatchesLeftLabels.count;
            break;
        case 3:
            count = statsLeftLabels.count;
            break;
        default:
            break;
    }
    NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:number]];
    }
    
    if (new == TRUE) {
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];

}

@end
