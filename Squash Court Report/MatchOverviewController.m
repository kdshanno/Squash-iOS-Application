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
#import "PointsCourtViewController.h"
#import "PointsListViewController.h"

@implementation MatchOverviewController

@synthesize gameSegControl, courtAreaPicker, match, statsTableView, tempCell, filterView, courtAreaButton;

- (void)initStatHeaders {
    statHeaders = [[NSMutableArray alloc] initWithObjects:@"WINNERS", @"ERRORS", @"UNFORCED", @"TOTAL", @"NO-LET", @"LET", @"STROKE", @"TOTAL", @"W:E RATIO", @"RALLY CONTROL MARGIN", nil];
}

- (NSMutableArray *)stringsForCellAtIndex:(int)index {
    NSSet *rallies = self.match.rallies;
    int gameNumber = self.gameSegControl.selectedSegmentIndex+1;
    if (gameNumber == self.gameSegControl.numberOfSegments) {
        gameNumber = -1;
    }
    NSMutableArray *strings = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", nil];
    NSSet *player1Stat;
    NSSet *player2Stat;
//    Add Strings
    switch (index) {
        case ROW_POINTS: {
            [strings replaceObjectAtIndex:0 withObject:@"POINTS"];
            NSPredicate *winnerPredicate = [NSPredicate predicateWithFormat:@"((finishingShot.intValue == %u) OR (finishingShot.intValue == %u))", kWinner, kStroke];
            NSPredicate *loserPredicate = [NSPredicate predicateWithFormat:@"((finishingShot.intValue == %u) OR (finishingShot.intValue == %u) OR (finishingShot.intValue == %u))", kError, kUnforcedError, kNoLet];
            NSPredicate *p1Finished = [NSPredicate predicateWithFormat:@"(p1Finished == YES)"];
            NSPredicate *p2Finished = [NSPredicate predicateWithFormat:@"(p1Finished == NO)"];
            player1Stat = [rallies filteredSetUsingPredicate:[NSCompoundPredicate orPredicateWithSubpredicates:[NSArray arrayWithObjects:[NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:winnerPredicate, p1Finished, nil]], [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:loserPredicate, p2Finished, nil]], nil]]];
           
            player2Stat = [rallies filteredSetUsingPredicate:[NSCompoundPredicate orPredicateWithSubpredicates:[NSArray arrayWithObjects:[NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:winnerPredicate, p2Finished, nil]], [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:loserPredicate, p1Finished, nil]], nil]]];
            
            break;
        }
        case ROW_WINNERS:
            [strings replaceObjectAtIndex:0 withObject:@"WINNERS"];
            player1Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == YES)", kWinner]];
            player2Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == NO)", kWinner]];
            break;
        case ROW_ERRORS:
            [strings replaceObjectAtIndex:0 withObject:@"ERRORS"];
            player1Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == YES)", kError]];
            player2Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == NO)", kError]];
            break;
        case ROW_UNFORCED_ERRORS:
            [strings replaceObjectAtIndex:0 withObject:@"UNFORCED"];
            player1Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == YES)", kUnforcedError]];
            player2Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == NO)", kUnforcedError]];
            break;
        case ROW_TOTAL_ERRORS:
            [strings replaceObjectAtIndex:0 withObject:@"TOTAL"];
            player1Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"((finishingShot.intValue == %u) OR (finishingShot.intValue == %u)) AND (p1Finished == YES)", kUnforcedError, kError]];
            player2Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"((finishingShot.intValue == %u) OR (finishingShot.intValue == %u)) AND (p1Finished == NO)", kUnforcedError, kError]];
            break;
        case ROW_LET:
            [strings replaceObjectAtIndex:0 withObject:@"LET"];
            player1Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == YES)", kLet]];
            player2Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == NO)", kLet]];
            break;
        case ROW_NO_LET:
            [strings replaceObjectAtIndex:0 withObject:@"NO-LET"];
            player1Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == YES)", kNoLet]];
            player2Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == NO)", kNoLet]];
            break;
        case ROW_STROKE:
            [strings replaceObjectAtIndex:0 withObject:@"STROKE"];
            player1Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == YES)", kStroke]];
            player2Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"(finishingShot.intValue == %u) AND (p1Finished == NO)", kStroke]];
            break;
        case ROW_TOTAL_STOKE_LET_NO_LET:
            [strings replaceObjectAtIndex:0 withObject:@"TOTAL"];
            player1Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"((finishingShot.intValue == %u) OR (finishingShot.intValue == %u) OR (finishingShot.intValue == %u)) AND (p1Finished == YES)", kStroke, kNoLet, kLet]];
            player2Stat = [rallies filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"((finishingShot.intValue == %u) OR (finishingShot.intValue == %u) OR (finishingShot.intValue == %u)) AND (p1Finished == NO)", kStroke, kNoLet, kLet]];
            break;
        case ROW_WE_RATIO:
            [strings replaceObjectAtIndex:0 withObject:@"W:E RATIO"];
            [strings replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.f", self.match.p1WERatio]];
            [strings replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.f", self.match.p2WERatio]];
            break;
        case ROW_RALLY_CONTROL_MARGIN:
            [strings replaceObjectAtIndex:0 withObject:@"RALLY CONTROL MARGIN"];
            [strings replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.f%%", self.match.p1RallyControlMargin*100]];
            [strings replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.f%%", self.match.p2RallyControlMargin*100]];
            break;
        default:
            break;
    }
    
//    Game Filter
    if (gameNumber != -1) {
        NSPredicate *gamePredicate = [NSPredicate predicateWithFormat:@"game.number.intValue == %u", gameNumber];
        player1Stat = [player1Stat filteredSetUsingPredicate:gamePredicate];
        player2Stat = [player2Stat filteredSetUsingPredicate:gamePredicate];
    }
//    Shot Location Filter
    
    courtAreaType selectedCourtArea = [Rally typeForString:[courtAreaPickerOptions objectAtIndex:[self.courtAreaPicker selectedRowInComponent:0]]];

    if (selectedCourtArea != CourtAreaFullCourt) {
        NSPredicate *areaPredicate = [NSPredicate predicateWithFormat:@"courtArea == %u", selectedCourtArea];
        player1Stat = [player1Stat filteredSetUsingPredicate:areaPredicate];
        player2Stat = [player2Stat filteredSetUsingPredicate:areaPredicate];

    }
    
    if (index != ROW_WE_RATIO && index != ROW_RALLY_CONTROL_MARGIN) {
        [strings replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%u", player1Stat.count]];
        [strings replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%u", player2Stat.count]];

    }
    
    return strings;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil match:(Match *)currentMatch
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.match = currentMatch;        
        cells = [[NSMutableDictionary alloc] init];
        pickerDown = CGRectMake(0, 416, 320, 216);
        pickerUp = CGRectMake(0, 200, 320, 216);
        courtAreaPickerOptions = [Rally courtAreaTypes];



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

- (void)gameSegControlChanged {
    [self.statsTableView reloadData];
}

- (void)resetCourtAreaSelection {
    
    if ([self.courtAreaPicker selectedRowInComponent:0] != -1) {
        self.courtAreaButton.title = [NSString stringWithFormat:@"Court Area: %@", [courtAreaPickerOptions objectAtIndex:[self.courtAreaPicker selectedRowInComponent:0]]];

    }
    [self.statsTableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.statsTableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Wood_Background.png"]]];
    self.title = @"Match Overview";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleFilterView)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.gameSegControl removeAllSegments];
    for (int i = 0; i < self.match.numberOfGames.intValue; i++) {
        [self.gameSegControl insertSegmentWithTitle:[NSString stringWithFormat:@"%u", i+1] atIndex:i animated:NO];
    }
    
    [self.gameSegControl insertSegmentWithTitle:@"Total" atIndex:self.match.numberOfGames.intValue animated:NO];
     
    [self.gameSegControl setSelectedSegmentIndex:self.gameSegControl.numberOfSegments-1];
    
    [self.gameSegControl addTarget:self action:@selector(gameSegControlChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.courtAreaPicker selectRow:0 inComponent:0 animated:NO];
    [self resetCourtAreaSelection];
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

-(void)fillFiltersP1:(ShotFilter *)p1Filter andP2:(ShotFilter *)p2Filter {
    
    p1Filter.courtArea = [Rally typeForString:[courtAreaPickerOptions objectAtIndex:[courtAreaPicker selectedRowInComponent:0]]];
    p2Filter.courtArea = [Rally typeForString:[courtAreaPickerOptions objectAtIndex:[courtAreaPicker selectedRowInComponent:0]]];

    if (gameSegControl.selectedSegmentIndex+1 != gameSegControl.numberOfSegments) {
        p1Filter.gameNumber = gameSegControl.selectedSegmentIndex+1;
        p2Filter.gameNumber = gameSegControl.selectedSegmentIndex+1;
    }
    else {
        p1Filter.gameNumber = 0;
        p2Filter.gameNumber = 0;

    }

    MatchOverviewCustomCell *winnerCell = [cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_WINNERS, 0]];
    p1Filter.winners = winnerCell.centerButton.filterOn;
    p2Filter.winners = winnerCell.rightButton.filterOn;
    
    MatchOverviewCustomCell *errorsCell = [cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_ERRORS, 0]];
    p1Filter.errors = errorsCell.centerButton.filterOn;
    p2Filter.errors = errorsCell.rightButton.filterOn;

    MatchOverviewCustomCell *unforcedCell = [cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_UNFORCED_ERRORS, 0]];
    p1Filter.unforcedErrors = unforcedCell.centerButton.filterOn;
    p2Filter.unforcedErrors = unforcedCell.rightButton.filterOn;

    MatchOverviewCustomCell *letCell = [cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_LET, 0]];
    p1Filter.lets = letCell.centerButton.filterOn;
    p2Filter.lets = letCell.rightButton.filterOn;

    MatchOverviewCustomCell *noLetCell = [cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_NO_LET, 0]];
    p1Filter.noLets = noLetCell.centerButton.filterOn;
    p2Filter.noLets = noLetCell.rightButton.filterOn;

    MatchOverviewCustomCell *strokeCell = [cells objectForKey:[NSString stringWithFormat:@"%u_%u", ROW_STROKE, 0]];
    p1Filter.strokes = strokeCell.centerButton.filterOn;
    p2Filter.strokes = strokeCell.rightButton.filterOn;

    
    
    
    
}
- (IBAction)listViewPicked:(id)sender {
    ShotFilter *p1Filter = [[ShotFilter alloc] init];
    ShotFilter *p2Filter = [[ShotFilter alloc] init];

    [self fillFiltersP1:p1Filter andP2:p2Filter];
    
    PointsListViewController *vc = [[PointsListViewController alloc] initWithMatch:self.match andPlayerOneFilter:p1Filter andPlayerTwoFilter:p2Filter];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)courtViewPicked:(id)sender {
    ShotFilter *p1Filter = [[ShotFilter alloc] init];
    ShotFilter *p2Filter = [[ShotFilter alloc] init];
    
    [self fillFiltersP1:p1Filter andP2:p2Filter];
    
    PointsCourtViewController *vc = [[PointsCourtViewController alloc] initWithNibName:@"PointsCourtViewController" bundle:nil andp1Filter:p1Filter andp2Filter:p2Filter andMatch:self.match];
    [self.navigationController pushViewController:vc animated:YES];

}
- (IBAction)filterButtonPressed:(id)sender {
    if (self.courtAreaPicker.frame.origin.y == pickerDown.origin.y) {
        [UIView animateWithDuration:0.3 animations:^(void){self.courtAreaPicker.frame = pickerUp;}];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^(void){self.courtAreaPicker.frame = pickerDown;}];
        [self resetCourtAreaSelection];


    }
    
}


#pragma mark - Table View Data Source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)configureCell:(MatchOverviewCustomCell *)cell {
    NSIndexPath *indexPath = cell.indexPath;
    
    NSMutableArray *strings = [self stringsForCellAtIndex:indexPath.row];
    [cell.leftButton setTitle:[strings objectAtIndex:0] forState:UIControlStateNormal];
    [cell.centerButton setTitle:[strings objectAtIndex:1] forState:UIControlStateNormal];
    [cell.rightButton setTitle:[strings objectAtIndex:2] forState:UIControlStateNormal];
    
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
    return 11;
    NSLog(@"%u",statHeaders.count);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return OVERVIEW_CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    StatsHeaderView *header = [[StatsHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    int gameNumber = self.gameSegControl.selectedSegmentIndex+1;
    NSString *gameString = [NSString stringWithFormat:@"GAME %u", gameNumber];
    if (gameNumber == self.gameSegControl.numberOfSegments) {
        gameString = @"TOTAL";
    }
    header.leftHeaderView.text = gameString;
    header.centerTopView.text = self.match.player1.firstName;
    header.centerBottomView.text = self.match.player1.lastName;
    header.rightTopView.text = self.match.player2.firstName;
    header.rightBottomView.text = self.match.player2.lastName;
    
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
    [self resetCourtAreaSelection];
    
}

#pragma mark - Picker Data Source

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return courtAreaPickerOptions.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

@end
