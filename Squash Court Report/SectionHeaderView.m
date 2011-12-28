//
//  SectionHeaderView.m
//  Squash Court Report
//
//  Created by Maxwell Shaw on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView
@synthesize label, sectionNumber, delegate, collapseIndicator;

- (void)sectionClicked {
    [self toggleCollapsed];
    [delegate sectionHeadedWasClicked:self];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PlayerProfileSectionDivider"]]];
        label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 280, 21)];
        [label setFont:[UIFont boldSystemFontOfSize:17.0]];
        [label setTextColor:[UIColor whiteColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        [self addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionClicked)];
        [self addGestureRecognizer:tap];
        [self setUserInteractionEnabled:YES];
        
        collapsed = FALSE;
        collapseIndicator = [[TriangleView alloc] initWithFrame:CGRectMake(285
                                                                           , 5, 11, 11)];
        CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI/2.0);

        collapseIndicator.transform = rotate;

        [self addSubview:collapseIndicator];
        // Initialization code
    }
    return self;
}

-(void)toggleCollapsed {
    collapsed = !collapsed;
    if (collapsed) {
        [UIView animateWithDuration:0.3 animations:^(void){
            collapseIndicator.transform = CGAffineTransformIdentity;
        }];
    }
    else [UIView animateWithDuration:0.3 animations:^(void){
        CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI/2.0);
        collapseIndicator.transform = rotate;
    }];
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
