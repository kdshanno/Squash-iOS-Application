//
//  SQRStepper.h
//  Squash Court Report
//
//  Created by Max Shaw on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQRStepper : UIControl

@property (nonatomic) double value; 
@property (nonatomic) double minimumValue;
@property (nonatomic) double maximumValue;
@property (strong, nonatomic) UIButton *minusButton;
@property (strong, nonatomic) UIButton *plusButton;

@end
