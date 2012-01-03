//
//  MatchOverviewController.h
//  Squash Court Report
//
//  Created by Max Shaw on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Match.h"
#import "MatchOverviewCustomCell.h"
#import "ShotFilter.h"

#define ROW_WINNERS 0
#define ROW_ERRORS 1
#define ROW_UNFORCED_ERRORS 2
#define ROW_TOTAL_ERRORS 3
#define ROW_NO_LET 4
#define ROW_LET 5
#define ROW_STROKE 6
#define ROW_TOTAL_STOKE_LET_NO_LET 7
#define ROW_WE_RATIO 8
#define ROW_RALLY_CONTROL_MARGIN 9


@interface MatchOverviewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, MatchOverviewCustomCellDelegate> {
    NSMutableArray *statHeaders;
    NSMutableArray *p1Stats;
    NSMutableArray *p2Stats;
    CGRect pickerDown;
    CGRect pickerUp;
    NSMutableArray *courtAreaPickerOptions;
    NSString *selectedCourtArea;
    NSMutableDictionary *cells;
    ShotFilter *p1Filter;
    ShotFilter *p2Filter;
 
    
}

@property (nonatomic, strong) IBOutlet UISegmentedControl *gameSegControl;
@property (nonatomic, strong) IBOutlet UIPickerView *courtAreaPicker;
@property (nonatomic, strong) Match *match;
@property (nonatomic, strong) IBOutlet UITableView *statsTableView;
@property (nonatomic, strong) IBOutlet MatchOverviewCustomCell *tempCell;
@property (nonatomic, strong) IBOutlet UIView *filterView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil match:(Match *)currentMatch;
- (IBAction)listViewPicked:(id)sender;
- (IBAction)courtViewPicked:(id)sender;
- (IBAction)filterButtonPressed:(id)sender;

@end
