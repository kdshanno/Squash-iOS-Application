//
//  CustomImageView.h
//  Squash Court Report
//
//  Created by Max Shaw on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomImageView : UIImageView {
    double xBallLocation;
    double yBallLocation;
    BOOL drawGuides;
}

@end
