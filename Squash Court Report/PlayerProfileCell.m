//
//  PlayerProfileCell.m
//  Squash Court Report
//
//  Created by Maxwell Shaw on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerProfileCell.h"

@implementation PlayerProfileCell

@synthesize leftLabel, rightLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        int cellWidth = self.contentView.frame.size.width;
        int cellHeight = PLAYERCELLHEIGHT;
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];

        // Initialization code
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PlayerProfileCell.png"]];
        [backgroundView setFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
        [self.contentView addSubview:backgroundView];
    
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, cellWidth/2-10, cellHeight)];
        [self.leftLabel setBackgroundColor:[UIColor clearColor]];
        //[self.leftLabel setTextColor:[UIColor redColor]];
        [self.leftLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [self.leftLabel setShadowOffset:CGSizeMake(0, -1)];
        [self.contentView addSubview:self.leftLabel];
        
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(cellWidth/2, 0, cellWidth/2-22, cellHeight)];
        [self.rightLabel setTextAlignment:UITextAlignmentRight];
        [self.rightLabel setTextColor:[UIColor redColor]];

        [self.rightLabel setMinimumFontSize:12];
        [self.rightLabel setAdjustsFontSizeToFitWidth:YES];
        [self.rightLabel setBackgroundColor:[UIColor clearColor]];

        [self.contentView addSubview:self.rightLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
