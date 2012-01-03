//
//  PointsListCell.h
//  Squash Court Report
//
//  Created by Rishi on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rally.h"

@interface PointsListCell : UITableViewCell {
    Rally *rally;
    UILabel *pointNumberLabel;
    UILabel *playerLabel;
    UILabel *outcomeLabel;
    UILabel *locationLabel;
}

- (void)setContentWithRally:(Rally *)r;
- (NSString *)locationForX:(double)x andY:(double)y;

@end
