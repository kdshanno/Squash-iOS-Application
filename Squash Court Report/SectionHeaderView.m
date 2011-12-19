//
//  SectionHeaderView.m
//  Squash Court Report
//
//  Created by Maxwell Shaw on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView
@synthesize label;

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
        // Initialization code
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
