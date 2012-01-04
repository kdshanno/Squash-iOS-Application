//
//  PointsCourtView.h
//  Squash Court Report
//
//  Created by Max Shaw on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShotFilter.h"
#import "CoreDataModel.h"
#import "PointsCourtView.h"
#import "LegendView.h"

@interface PointsCourtViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>{
    NSArray *p1RallyArray;
    NSArray *p2RallyArray;
    CGRect legendViewDown;
    CGRect legendViewUp;
}

@property (nonatomic, retain) Match *match;
@property (nonatomic, retain) ShotFilter *p1Filter;
@property (nonatomic, retain) ShotFilter *p2Filter;
@property (nonatomic, retain) IBOutlet PointsCourtView *courtView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollview;
@property (nonatomic, retain) IBOutlet UITableView *legendTableView;
@property (nonatomic, retain) IBOutlet LegendView *legendView;
@property (nonatomic, retain) IBOutlet UIView *opaqueView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andp1Filter:(ShotFilter *)p1Filt andp2Filter:(ShotFilter *)p2Filt andMatch:(Match *)m;

@end
