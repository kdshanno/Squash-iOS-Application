//
//  MatchOverviewController.m
//  Squash Court Report
//
//  Created by Max Shaw on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MatchOverviewController.h"
#import "Rally.h"
#import "StatsHeaderView.h"

@implementation MatchOverviewController

@synthesize gameSegControl, courtAreaPicker, match, statsTableView, tempCell;
- (void)initStatHeaders {
    statHeaders = [[NSMutableArray alloc] initWithObjects:@"Winners", @"Errors", @"Unforced", @"Total", @"No-Let", @"Let", @"Stroke", @"Total", @"W:E Ratio", @"Rally Control Margin", nil];
}

- (void)initP1Stats {
    p1Stats = [[NSMutableArray alloc] init];
    NSSet *rallies = self.match.rallies;
    NSSet *p1Winners = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == YES)", kWinner]];
    NSSet *p1Errors = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == YES)", kError]];
    NSSet *p1Unforced = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == YES)", kUnforcedError]];
    NSSet *p1NoLet = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == YES)", kNoLet]];
    NSSet *p1Let = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == YES)", kNoLet]];
    NSSet *p1Stroke = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == YES)", kStroke]];
    
    [p1Stats addObject:[NSString stringWithFormat:@"%u", p1Winners.count]];
    [p1Stats addObject:[NSString stringWithFormat:@"%u", p1Errors.count]];
    [p1Stats addObject:[NSString stringWithFormat:@"%u", p1Unforced.count]];
    [p1Stats addObject:[NSString stringWithFormat:@"%u", p1Errors.count + p1Unforced.count]];
    [p1Stats addObject:[NSString stringWithFormat:@"%u", p1NoLet.count]];
    [p1Stats addObject:[NSString stringWithFormat:@"%u", p1Let.count]];
    [p1Stats addObject:[NSString stringWithFormat:@"%u", p1Stroke.count]];
    [p1Stats addObject:[NSString stringWithFormat:@"%u", p1Stroke.count + p1NoLet.count + p1Let.count]];

    [p1Stats addObject:[NSString stringWithFormat:@"%u", self.match.p1WERatio]];
    [p1Stats addObject:[NSString stringWithFormat:@"%u", self.match.p1RallyControlMargin]];

}

- (void)initP2Stats {
    p2Stats = [[NSMutableArray alloc] init];
    NSSet *rallies = self.match.rallies;
    NSSet *p2Winners = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == NO)", kWinner]];
    NSSet *p2Errors = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == NO)", kError]];
    NSSet *p2Unforced = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == NO)", kUnforcedError]];
    NSSet *p2NoLet = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == NO)", kNoLet]];
    NSSet *p2Let = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == NO)", kNoLet]];
    NSSet *p2Stroke = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == NO)", kStroke]];
    
    [p2Stats addObject:[NSString stringWithFormat:@"%u", p2Winners.count]];
    [p2Stats addObject:[NSString stringWithFormat:@"%u", p2Errors.count]];
    [p2Stats addObject:[NSString stringWithFormat:@"%u", p2Unforced.count]];
    [p2Stats addObject:[NSString stringWithFormat:@"%u", p2Errors.count + p2Unforced.count]];
    [p2Stats addObject:[NSString stringWithFormat:@"%u", p2NoLet.count]];
    [p2Stats addObject:[NSString stringWithFormat:@"%u", p2Let.count]];
    [p2Stats addObject:[NSString stringWithFormat:@"%u", p2Stroke.count]];
    [p2Stats addObject:[NSString stringWithFormat:@"%u", p2Stroke.count + p2NoLet.count + p2Let.count]];

    [p2Stats addObject:[NSString stringWithFormat:@"%u", self.match.p2WERatio]];
    [p2Stats addObject:[NSString stringWithFormat:@"%u", self.match.p2RallyControlMargin]];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil match:(Match *)currentMatch
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.match = currentMatch;
        [self initStatHeaders];
        [self initP1Stats];
        [self initP2Stats];
        if (statHeaders.count != p1Stats.count) {
            NSLog(@"ERROR");
        }
        
        cells = [[NSMutableDictionary alloc] init];
        pickerDown = CGRectMake(0, 416, 320, 216);
        pickerUp = CGRectMake(0, 200, 320, 216);
        courtAreaPickerOptions = [[NSMutableArray alloc] initWithObjects:@"Front Left", @"Front Middle", @"Front Right", @"Middle Left", @"Middle Middle", @"Middle Right", @"Back Left", @"Back Middle", @"Back Right", nil];

        p1Filter = [[ShotFilter alloc] init];
        p2Filter = [[ShotFilter alloc] init];


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
    
    [self.statsTableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Wood_Background.png"]]];
    self.title = @"Match Overview";
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

#pragma mark - Buttons

- (IBAction)listViewPicked:(id)sender {
    
}
- (IBAction)courtViewPicked:(id)sender {
    
}
- (IBAction)filterButtonPressed:(id)sender {
    [UIView animateWithDuration:0.5 animations:^(void){self.courtAreaPicker.frame = pickerUp;}];
    
}


#pragma mark - Table View Data Source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)configureCell:(MatchOverviewCustomCell *)cell {
    NSIndexPath *indexPath = cell.indexPath;
    
    [cell.leftButton setTitle:[statHeaders objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [cell.centerButton setTitle:[p1Stats objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [cell.rightButton setTitle:[p2Stats objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
    switch (indexPath.row) {
        case ROW_WINNERS:
            cell.highlightColor = [UIColor greenColor];
            break;
        case ROW_ERRORS:
            cell.highlightColor = [UIColor redColor];
            break;
        case ROW_UNFORCED_ERRORS:
            cell.highlightColor = [UIColor orangeColor];
            break;
        case ROW_TOTAL_ERRORS:
            cell.highlightColor = [UIColor orangeColor];
            break;
        case ROW_NO_LET:
            cell.highlightColor = [UIColor orangeColor];
            break;

        default:
            break;
    }
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellid = [NSString stringWithFormat:@"%u_%u", indexPath.row, indexPath.section];
    MatchOverviewCustomCell *cell = [cells objectForKey:cellid];
    if (cell == nil) {
        cell = [[MatchOverviewCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OverviewCustomCell"];
        [cells setObject:cell forKey:cellid];
    }
    cell.indexPath = indexPath;
    [self configureCell:cell];

    return cell;
}

#pragma mark - Table View Delegate

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NULL;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return statHeaders.count;
    NSLog(@"%u",statHeaders.count);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    StatsHeaderView *header = [[StatsHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 44) andMatch:self.match];
    return header;
}
#pragma mark - Cell Delegate




#pragma mark - Picker Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [courtAreaPickerOptions objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [UIView animateWithDuration:0.5 animations:^(void){pickerView.frame = pickerDown;}];
    
}

#pragma mark - Picker Data Source

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return courtAreaPickerOptions.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

@end
