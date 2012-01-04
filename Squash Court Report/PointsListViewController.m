//
//  PointsListViewController.m
//  Squash Court Report
//
//  Created by Rishi on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PointsListViewController.h"
#import "PointsListCell.h"
#import "Rally.h"
#import "Player.h"

@implementation PointsListViewController

- (PointsListViewController *)initWithMatch:(Match *)m andPlayerOneFilter:(ShotFilter *)filterOne andPlayerTwoFilter:(ShotFilter *)filterTwo
{
    filters[0] = filterOne;
    
    if(filters[0] == nil)
        filters[0] = [[ShotFilter alloc] initShowAll];
    
    filters[1] = filterTwo;
    
    if(filters[1] == nil)
        filters[1] = [[ShotFilter alloc] initShowAll];

    if(m == nil)
        abort();
    
    match = m;
    
    return [self initWithStyle:UITableViewStyleGrouped];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        [self.tableView setRowHeight:40]; 
        
        self.title = NSLocalizedString(@"List View", "List View");
        
        for (int i = 0; i < 5; i++)
            expandedGames[i] = YES;
        
        games = [NSMutableArray arrayWithCapacity:[[match games] count]];
        Game *arrayOfGames[5];
        int numGames = 0;
        for(Game *game in match.games)
        {
            arrayOfGames[[game.number intValue] - 1] = game;
            numGames++;
        }
        
        pointArrays = [NSMutableArray arrayWithCapacity:numGames];
        for(int i = 0; i < numGames; i++)
        {
            Game *g = arrayOfGames[i];
            [games insertObject:g atIndex:i];
            
            NSSortDescriptor *sd =[NSSortDescriptor sortDescriptorWithKey:@"pointNumber" ascending:YES];
            NSArray *sdArray = [NSArray arrayWithObjects:sd, nil];
            NSMutableArray *points = [NSMutableArray arrayWithArray:[[g rallies] 
                                                                     sortedArrayUsingDescriptors:sdArray]];
            points = [self filterOutPoints:points];
            [pointArrays insertObject:points atIndex:i];
        }
    }
    
    return self;
}

- (NSMutableArray *)filterOutPoints:(NSMutableArray *)points
{
    int size = [points count];
    int index = 0;
    for (int iteration = 0; iteration < size; iteration++) 
    {
        if ([self keepPoint:[points objectAtIndex:index]]) 
            index++;
        else
            [points removeObjectAtIndex:index];
    }
    
    return points;
}

- (BOOL)keepPoint:(Rally *)rally
{
    int index;
    if([rally.p1Finished boolValue])
        index = 0;
    else
        index = 1;
    
    switch ([rally.finishingShot intValue]) {
        case kError:
            return [filters[index] errors];
            break;
        case kLet:
            return [filters[index] lets];
            break; 
        case kNoLet:
            return [filters[index] noLets];
            break; 
        case kStroke:
            return [filters[index] strokes];
            break; 
        case kWinner:
            return [filters[index] winners];
            break; 
        case kUnforcedError:
            return [filters[index] unforcedErrors];
            break;
        default:
            abort();
            break;
;
    }
    
    
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
    return [games count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(!expandedGames[section])
        return 1;
    else
    {
        return [[pointArrays objectAtIndex:section] count] + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PointCell = @"PointCell";
    static NSString *TextCell = @"TextCell";
    
    UITableViewCell *cell;
    
    if(expandedGames[indexPath.section] && (indexPath.row + 1 != [self tableView:self.tableView numberOfRowsInSection:indexPath.section]))
    {
        PointsListCell *customCell = [tableView dequeueReusableCellWithIdentifier:PointCell];
        if (customCell == nil) {
            customCell = [[PointsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PointCell];
            [customCell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        
        NSArray *points = [pointArrays objectAtIndex:indexPath.section];
        Rally *r = [points objectAtIndex:indexPath.row];
        [customCell setContentWithRally:r inMatch:match];
        
        cell = customCell;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:TextCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextCell];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
            [cell.textLabel setTextColor:[UIColor darkGrayColor]];
        }
        
        if(expandedGames[indexPath.section])
        {
            [cell.textLabel setText:@"Collapse"];
        }
        else
        {
            [cell.textLabel setText:@"Expand"];
        }
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Game %d", section + 1];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    [header setBackgroundColor:[UIColor clearColor]];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(14, -2, 100, 50)];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setText:[NSString stringWithFormat:@"Game %d", section + 1]];
    [title setFont:[UIFont boldSystemFontOfSize:17]];
    [title setTextColor:[UIColor darkGrayColor]];
    [header addSubview:title];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = section;
    
    UIImage *image;
    if(expandedGames[section])
        image = [UIImage imageNamed:@"expanded.png"];
    else
        image = [UIImage imageNamed:@"collapsed.png"];

    
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(expandCollapse:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:button];
    [button setFrame:CGRectMake(280, 20, 14, 15)];
    
    return header;
}

- (void)expandCollapse:(id)b
{
    UIButton *button = b;
    if(expandedGames[button.tag])
    {
        //Code to collapse
        [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:([self tableView:self.tableView numberOfRowsInSection:button.tag]-1) inSection:button.tag]];
       
        CGAffineTransform transform = CGAffineTransformMakeRotation(-3.14/2.0);
        [UIView animateWithDuration:0.17 animations:^{button.transform = transform;}];
                                   
    }
    else
    {
        //Code to expand
        [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:button.tag]];
        
        CGAffineTransform transform = CGAffineTransformMakeRotation(3.14/2.0);
        [UIView animateWithDuration:0.17 animations:^{button.transform = transform;}];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    Game *game = [games objectAtIndex:section];
    
    NSString *gameString = @"";
    
    switch (section + 1) {
        case 1:
            gameString = @"one";
            break;
        case 2:
            gameString = @"two";
            break;
        case 3:
            gameString = @"three";
            break;
        case 4:
            gameString = @"four";
            break;
        case 5:
            gameString = @"five";
            break;
        default:
            abort();
            break;
    }
    
    if([game.p1Score intValue] > [game.p2Score intValue])
        return [NSString stringWithFormat:@"%@ won game %@ (%d - %d)", [match.player1 getName:kFirstInitialLastInitial], gameString, [game.p1Score intValue], [game.p2Score intValue]];
    else
        return [NSString stringWithFormat:@"%@ won game %@ (%d - %d)", [match.player2 getName:kFirstInitialLastInitial], gameString, [game.p2Score intValue], [game.p1Score intValue]];

    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(expandedGames[indexPath.section] && (indexPath.row + 1 == [self tableView:self.tableView numberOfRowsInSection:indexPath.section]))
    {
        //Collapse the section
        expandedGames[indexPath.section] = !expandedGames[indexPath.section];
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (!expandedGames[indexPath.section])
    {
        //Expand the section
        expandedGames[indexPath.section] = !expandedGames[indexPath.section];
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
