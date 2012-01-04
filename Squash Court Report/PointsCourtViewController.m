//
//  PointsCourtView.m
//  Squash Court Report
//
//  Created by Max Shaw on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PointsCourtViewController.h"
#import "LegendView.h"
#import "LegendsCell.h"

@implementation PointsCourtViewController

@synthesize p1Filter, p2Filter, match, courtView, scrollview, legendTableView, legendView, opaqueView;

- (void)fillRallyArray {
    p1RallyArray = [self.match getShotsWithFilter:p1Filter withPlayer1:YES];
    p2RallyArray = [self.match getShotsWithFilter:p2Filter withPlayer1:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andp1Filter:(ShotFilter *)p1Filt andp2Filter:(ShotFilter *)p2Filt andMatch:(Match *)m
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.match = m;
        self.p1Filter = p1Filt;
        self.p2Filter = p2Filt;
        
        [self fillRallyArray];
        
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

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.courtView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    NSLog(@"%f", scale);
    self.courtView.scale = scale;
}

- (void)legendButtonPressed {
    if (self.legendView.frame.origin.y == legendViewDown.origin.y) {
        [UIView animateWithDuration:0.3 animations:^(void){
            self.legendView.frame = legendViewUp;
            [opaqueView setAlpha:0.5];
        }];
    }
    else [UIView animateWithDuration:0.3 animations:^(void){
        self.legendView.frame = legendViewDown;
        [opaqueView setAlpha:0.0];

    }];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    courtView.p1RallyArray = p1RallyArray;
    courtView.p2RallyArray = p2RallyArray;
    self.scrollview.delegate = self;
    
    legendViewDown = self.legendView.frame;
    legendViewUp = CGRectOffset(legendViewDown, 0, -legendViewDown.size.height);
    
    UIBarButtonItem *legend = [[UIBarButtonItem alloc] initWithTitle:@"Legend" style:UIBarButtonItemStyleBordered target:self action:@selector(legendButtonPressed)];
    self.navigationItem.rightBarButtonItem = legend;
    

    [self.legendTableView setBackgroundColor:[UIColor clearColor]];
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

#pragma mark - Legend View Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LegendsCell *cell = [[LegendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    switch (indexPath.row) {
        case kWinner:
            cell.legendKeyLabel.text = @"WINNER";
            cell.finishingShot = kWinner;

            break;
        case kError:
            cell.legendKeyLabel.text = @"ERROR";
            cell.finishingShot = kError;

            break;
        case kUnforcedError:
            cell.legendKeyLabel.text = @"UNFORCED";
            cell.finishingShot = kUnforcedError;

            break;
        case kLet:
            cell.legendKeyLabel.text = @"LET";
            cell.finishingShot = kLet;

            break;
        case kNoLet:
            cell.legendKeyLabel.text = @"NO-LET";
            cell.finishingShot = kNoLet;

            break;
        case kStroke:
            cell.legendKeyLabel.text = @"STROKE";
            cell.finishingShot = kStroke;

            break;
            
        default:
            break;
    }
    return cell;
}

#pragma mark - Legend View Delegate

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    sectionView.backgroundColor = [UIColor clearColor];
    UILabel *leftHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, sectionView.frame.size.height)];
//    leftHeaderView.text = @"STAT";
    
    UILabel *centerTopView = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 80, sectionView.frame.size.height/2)];
    centerTopView.text = [self.match.player1.firstName uppercaseString];
    
    UILabel *centerBottomView = [[UILabel alloc] initWithFrame:CGRectMake(120, sectionView.frame.size.height/2, 80, sectionView.frame.size.height/2)];
    centerBottomView.text = [self.match.player1.lastName uppercaseString];
    
    UILabel *rightTopView = [[UILabel alloc] initWithFrame:CGRectMake(220, 0, 80, sectionView.frame.size.height/2)];
    rightTopView.text = [self.match.player2.firstName uppercaseString];
    
    UILabel *rightBottomView = [[UILabel alloc] initWithFrame:CGRectMake(220, sectionView.frame.size.height/2, 80, sectionView.frame.size.height/2)];
    rightBottomView.text = [self.match.player2.lastName uppercaseString];
    
    NSArray *labels = [NSArray arrayWithObjects:leftHeaderView, centerTopView, centerBottomView, rightTopView, rightBottomView, nil];
    
   
    for (UILabel *label in labels) {
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        [sectionView addSubview:label];
    }
    
    return sectionView;

}

@end
