//
//  SQRStepper.m
//  Squash Court Report
//
//  Created by Max Shaw on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SQRStepper.h"

@implementation SQRStepper

@synthesize value, minimumValue, maximumValue, minusButton, plusButton;

- (void)minusButtonPressed {
    if (self.value > self.minimumValue) {
        self.value--;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)plusButtonPressed {
    self.value++;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, 94, 27);
        self.minimumValue = 0;
        self.maximumValue = 100;
        self.minusButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 47, 27)];
        [self.minusButton setImage:[UIImage imageNamed:@"StepperMinusButton"] forState:UIControlStateNormal];
        [self.minusButton setImage:[UIImage imageNamed:@"StepperMinusButtonSelected"] forState:UIControlStateHighlighted];
        [self.minusButton addTarget:self action:@selector(minusButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.minusButton];
        
        self.plusButton = [[UIButton alloc] initWithFrame:CGRectMake(47, 0, 47, 27)];
        [self.plusButton setImage:[UIImage imageNamed:@"StepperPlusButton"] forState:UIControlStateNormal];
        [self.plusButton setImage:[UIImage imageNamed:@"StepperPlusButtonSelected"] forState:UIControlStateHighlighted];
        [self.plusButton addTarget:self action:@selector(plusButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.plusButton];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
