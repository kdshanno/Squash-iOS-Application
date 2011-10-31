//
//  PersonViewCell.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayersViewCell.h"

@implementation PlayersViewCell

@synthesize mainLabel, leftImageView, detailLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Set Up Cell
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
           
        // Initialize Image and Label
        self.leftImageView = [[UIImageView alloc] init];
        [self.leftImageView setFrame:CGRectMake(5, 5, 50, 50)];
        [self.leftImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.leftImageView setClipsToBounds:YES];
        [self.leftImageView setBackgroundColor:[UIColor colorWithRed:20 green:20 blue:20 alpha:1.0]];
        
        // Set Up Main Label

        self.mainLabel = [[UILabel alloc] init];
        [self.mainLabel setFrame:CGRectMake(63, 9, 243, 21)];
        [self.mainLabel setTextAlignment:UITextAlignmentLeft];
        [self.mainLabel setTextColor:[UIColor redColor]];
        [self.mainLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        
        // Set Up Detail Label
        self.detailLabel = [[UILabel alloc] init];
        [self.detailLabel setFrame:CGRectMake(71, 33, 229, 21)];
        [self.detailLabel setTextAlignment:UITextAlignmentLeft];
        [self.detailLabel setTextColor:[UIColor blackColor]];
        [self.detailLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];


        // Add views to cell
        [self.contentView addSubview:self.leftImageView];
        [self.contentView addSubview:self.mainLabel];
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
