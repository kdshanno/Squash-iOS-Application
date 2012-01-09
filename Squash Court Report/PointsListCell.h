//
//  PointsListCell.h
//  Squash Court Report
//
//  Created by Rishi on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rally.h"
#import "Match.h"

@interface PointsListCell : UITableViewCell {
    Rally *rally;
    UILabel *pointNumberLabel;
    UILabel *playerLabel;
    UILabel *outcomeLabel;
    UILabel *locationLabel;
}

- (void)setContentWithRally:(Rally *)r inMatch:(Match *)m;
- (NSString *)relativeLocationForX:(double)x andY:(double)y;

@end
