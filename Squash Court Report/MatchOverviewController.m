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

@synthesize gameSegControl, courtAreaPicker, match, statsTableView, tempCell, filterView;
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

- (void)toggleFilterView {
    if (self.filterView.frame.origin.y != 0) {
        [UIView animateWithDuration:.3 animations:^(void){
            CGRect frame = self.filterView.frame;
            CGFloat height = frame.size.height;
            frame = CGRectOffset(frame, 0, frame.size.height);
            self.filterView.frame = frame;
            
            CGRect tableFrame = self.statsTableView.frame;
            tableFrame = CGRectMake(0, frame.origin.y + height, 320, tableFrame.size.height-height);
            self.statsTableView.frame = tableFrame;
        }];
    }
    else {
        [UIView animateWithDuration:.3 animations:^(void){
            CGRect frame = self.filterView.frame;
            CGFloat height = frame.size.height;

            frame = CGRectOffset(frame, 0, -frame.size.height);
            self.filterView.frame = frame;
            
            CGRect tableFrame = self.statsTableView.frame;
            tableFrame = CGRectMake(0, frame.origin.y + height, 320, tableFrame.size.height+height);
            self.statsTableView.frame = tableFrame;

        }];

    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.statsTableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Wood_Background.png"]]];
    self.title = @"Match Overview";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleFilterView)];
    self.navigationItem.rightBarButtonItem = item;
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
    if (self.courtAreaPicker.frame.origin.y == pickerDown.origin.y) {
        [UIView animateWithDuration:0.3 animations:^(void){self.courtAreaPicker.frame = pickerUp;}];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^(void){self.courtAreaPicker.frame = pickerDown;}];

    }
    
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
            cell.highlightColor = [ShotFilter winnersColor];
            break;
        case ROW_ERRORS:
            cell.highlightColor = [ShotFilter errorsColor];
            break;
        case ROW_UNFORCED_ERRORS:
            cell.highlightColor = [ShotFilter unforcedErrorsColor];
            break;
        case ROW_TOTAL_ERRORS:
            cell.highlightColor = [UIColor redColor];
            break;
        case ROW_NO_LET:
            cell.highlightColor = [ShotFilter noLetsColor];
            break;
        case ROW_LET:
            cell.highlightColor = [ShotFilter letsColor];
            break;
        case ROW_STROKE:
            cell.highlightColor = [ShotFilter strokesColor];
            break;
        case ROW_TOTAL_STOKE_LET_NO_LET:
            cell.highlightColor = [UIColor redColor];
            break;
        case ROW_WE_RATIO:
            cell.highlightColor = [UIColor redColor];
            break;
        case ROW_RALLY_CONTROL_MARGIN:
            cell.highlightColor = [UIColor redColor];
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
    cell.delegate = self;
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

- (void)leftButtonWasSelectedAtIndexPath:(NSIndexPath *)indexpath {
    NSString *path = [NSString stringWithFormat:@"%u_%u", indexpath.row, indexpath.section];
    MatchOverviewCustomCell *cell = (MatchOverviewCustomCell *)[cells objectForKey:path];
    BOOL t = cell.centerButton.filterOn;

    switch (indexpath.row) 
    {
        case (ROW_WINNERS):
        case (ROW_ERRORS):
        case (ROW_UNFORCED_ERRORS):
        case (ROW_STROKE):
        case (ROW_LET):
        case (ROW_NO_LET):
            [cell setCenterButtonSelected:!t];
            [cell setRightButtonSelected:!t];
            break;
        case (ROW_TOTAL_ERRORS): {
            MatchOverviewCustomCell *errorsCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_ERRORS, 0]];
            MatchOverviewCustomCell *unforcedCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_UNFORCED_ERRORS, 0]];
            t = errorsCell.rightButton.filterOn;
            [errorsCell setRightButtonSelected:!t];
            [unforcedCell setRightButtonSelected:!t];
            [errorsCell setCenterButtonSelected:!t];
            [unforcedCell setCenterButtonSelected:!t];
            break;
        }
        case (ROW_TOTAL_STOKE_LET_NO_LET): {
            MatchOverviewCustomCell *strokeCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_STROKE, 0]];
            MatchOverviewCustomCell *letCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_LET, 0]];
            MatchOverviewCustomCell *noLetCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_NO_LET, 0]];
            
            t = strokeCell.rightButton.filterOn;
            [strokeCell setRightButtonSelected:!t];
            [letCell setRightButtonSelected:!t];
            [noLetCell setRightButtonSelected:!t];
            [strokeCell setCenterButtonSelected:!t];
            [letCell setCenterButtonSelected:!t];
            [noLetCell setCenterButtonSelected:!t];

            
            break;
        }

        default:
            break;
    }
}

- (void)centerButtonWasSelectedAtIndexPath:(NSIndexPath *)indexpath {
    NSString *path = [NSString stringWithFormat:@"%u_%u", indexpath.row, indexpath.section];
    MatchOverviewCustomCell *cell = (MatchOverviewCustomCell *)[cells objectForKey:path];
    BOOL t = cell.centerButton.filterOn;
    
    switch (indexpath.row) 
    {
        case (ROW_WINNERS):
        case (ROW_ERRORS):
        case (ROW_UNFORCED_ERRORS):
        case (ROW_STROKE):
        case (ROW_LET):
        case (ROW_NO_LET):
            [cell setCenterButtonSelected:!t];
            break;
        case (ROW_TOTAL_ERRORS): {
            MatchOverviewCustomCell *errorsCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_ERRORS, 0]];
            MatchOverviewCustomCell *unforcedCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_UNFORCED_ERRORS, 0]];
            t = errorsCell.centerButton.filterOn;
            [errorsCell setCenterButtonSelected:!t];
            [unforcedCell setCenterButtonSelected:!t];
            break;
        }
        case (ROW_TOTAL_STOKE_LET_NO_LET): {
            MatchOverviewCustomCell *strokeCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_STROKE, 0]];
            MatchOverviewCustomCell *letCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_LET, 0]];
            MatchOverviewCustomCell *noLetCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_NO_LET, 0]];
            
            t = strokeCell.centerButton.filterOn;
            [strokeCell setCenterButtonSelected:!t];
            [letCell setCenterButtonSelected:!t];
            [noLetCell setCenterButtonSelected:!t];
            
            break;
        }

            
        default:
            break;
    }
    
}

- (void)rightButtonWasSelectedAtIndexPath:(NSIndexPath *)indexpath {
    NSString *path = [NSString stringWithFormat:@"%u_%u", indexpath.row, indexpath.section];
    MatchOverviewCustomCell *cell = (MatchOverviewCustomCell *)[cells objectForKey:path];
    BOOL t = cell.rightButton.filterOn;
    
    switch (indexpath.row) 
    {
        case (ROW_WINNERS):
        case (ROW_ERRORS):
        case (ROW_UNFORCED_ERRORS):
        case (ROW_STROKE):
        case (ROW_LET):
        case (ROW_NO_LET):
            [cell setRightButtonSelected:!t];
            break;
        case (ROW_TOTAL_ERRORS): {
            MatchOverviewCustomCell *errorsCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_ERRORS, 0]];
            MatchOverviewCustomCell *unforcedCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_UNFORCED_ERRORS, 0]];
            t = errorsCell.rightButton.filterOn;
            [errorsCell setRightButtonSelected:!t];
            [unforcedCell setRightButtonSelected:!t];
            break;
        }
        case (ROW_TOTAL_STOKE_LET_NO_LET): {
            MatchOverviewCustomCell *strokeCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_STROKE, 0]];
            MatchOverviewCustomCell *letCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_LET, 0]];
            MatchOverviewCustomCell *noLetCell = (MatchOverviewCustomCell *)[cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_NO_LET, 0]];

            t = strokeCell.rightButton.filterOn;
            [strokeCell setRightButtonSelected:!t];
            [letCell setRightButtonSelected:!t];
            [noLetCell setRightButtonSelected:!t];

            break;
        }


            
        default:
            break;
    }
    
}


#pragma mark - Picker Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [courtAreaPickerOptions objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [UIView animateWithDuration:0.3 animations:^(void){pickerView.frame = pickerDown;}];
    
}

#pragma mark - Picker Data Source

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return courtAreaPickerOptions.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

@end
