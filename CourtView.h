//
//  CustumImageView.h
//  Squash Court Report
//
//  Created by Max Shaw on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourtView : UIView {
    double x;
    double y;
}

@property BOOL drawDot;

-(void)setX:(double)x andY:(double)y;

@end