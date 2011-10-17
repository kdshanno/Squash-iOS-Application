//
//  PlayerProfileTopCell.m
//  Squash Court Report
//
//  Created by Maxwell Shaw on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerProfileTopCell.h"

@implementation PlayerProfileTopCell

@synthesize topLabel, bottomLabel, detailLabel, leftImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        int cellWidth = self.contentView.frame.size.width;
        int cellHeight = kPlayerTopCellHeight;
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // Initialization code
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PlayerProfileTop.png"]];
        [backgroundView setFrame:CGRectMake(2, 0, cellWidth-7, cellHeight)];
        [self.contentView addSubview:backgroundView];
        
        self.leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(23, 16, 101, 112)];
        [self.leftImage setContentMode:UIViewContentModeScaleAspectFill];
        [self.leftImage setClipsToBounds:YES];
        [self.leftImage setImage:[UIImage imageNamed:@"PlayerProfileSectionDivider.png"]];
        [self.contentView addSubview:self.leftImage];
        
        
        int leftSideLabels = 140;
        int labelWidth = 320-leftSideLabels-20;
        
        self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSideLabels, 15, labelWidth, 35)];
        [self.topLabel setFont:[UIFont boldSystemFontOfSize:30]];
        [self.topLabel setBackgroundColor:[UIColor clearColor]];
        self.topLabel.text = @"Top Label";
        [self.contentView addSubview:self.topLabel];
        
        self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSideLabels, 15+40, labelWidth, 30)];
        [self.bottomLabel setFont:[UIFont boldSystemFontOfSize:30]];
        [self.bottomLabel setBackgroundColor:[UIColor clearColor]];
        self.bottomLabel.text = @"Bottom Label";

        [self.contentView addSubview:self.bottomLabel];

        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSideLabels, 15+40*2, labelWidth, 30)];
        [self.detailLabel setFont:[UIFont systemFontOfSize:20]];
        self.detailLabel.text = @"Detail Label";

        [self.detailLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.detailLabel];


        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
