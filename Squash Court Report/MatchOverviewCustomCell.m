//
//  MatchOverviewCustomCell.m
//  Squash Court Report
//
//  Created by Max Shaw on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MatchOverviewCustomCell.h"

@implementation MatchOverviewCustomCell

@synthesize leftButton, centerButton, rightButton, indexPath, delegate;
@synthesize highlightColor = _highlightColor;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftButton = [[SquareButton alloc] initWithFrame:CGRectMake(0+1, 0+1, 120-2, self.frame.size.height-2)];
        self.centerButton = [[SquareButton alloc] initWithFrame:CGRectMake(121, 1, 100-2, self.frame.size.height-2)];
        self.rightButton = [[SquareButton alloc] initWithFrame:CGRectMake(220+1, 1, 100-2, self.frame.size.height-2)];
        
        [self.leftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.centerButton addTarget:self action:@selector(centerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

        self.leftButton.highLightColor = [UIColor redColor];
        self.centerButton.highLightColor = [UIColor redColor];
        self.rightButton.highLightColor = [UIColor redColor];

        
        [self addSubview:self.leftButton];
        [self addSubview:self.centerButton];
        [self addSubview:self.rightButton];
        // Initialization code
    }
    return self;
}

- (void)setHighlightColor:(UIColor *)highlightColor {
    self.leftButton.highLightColor = highlightColor;
    self.centerButton.highLightColor = highlightColor;
    self.rightButton.highLightColor = highlightColor;

    _highlightColor = highlightColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)highlightRow:(MatchOverviewCustomCell *)cell {
    BOOL t = cell.centerButton.selected;
    [cell.centerButton setHighlighted:!t];
    [cell.centerButton setSelected:!t];
    
    [cell.rightButton setHighlighted:!t];
    [cell.rightButton setSelected:!t];

}
- (void)toggleButton:(UIButton *)button {
    BOOL t = button.selected;
    [button setHighlighted:!t];
    [button setSelected:!t];
}

- (IBAction)leftButtonPressed:(id)sender {
//    [self performSelector:@selector(highlightButton:) withObject:sender afterDelay:0.0];

}
- (IBAction)centerButtonPressed:(id)sender {
    [self performSelector:@selector(toggleButton:) withObject:sender afterDelay:0.0];

}
- (IBAction)rightButtonPressed:(UIButton *)sender {
    [self performSelector:@selector(toggleButton:) withObject:sender afterDelay:0.0];
//    [self performSelector:@selector(highlightButton:) withObject:sender afterDelay:0.0];

}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *tan = [UIColor colorWithRed:254.0/255.0 green:241.0/255.0 blue:183.0/255.0 alpha:1.0];
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, self.bounds);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokeRect(context, self.bounds);

    CGContextMoveToPoint(context, 120, 0);
    CGContextAddLineToPoint(context, 120, self.bounds.size.height);
    

    CGContextMoveToPoint(context, 220, 0);
    CGContextAddLineToPoint(context, 220, self.bounds.size.height);
    
    CGContextStrokePath(context);

}


@end
