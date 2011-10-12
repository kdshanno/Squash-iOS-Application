//
//  PersonViewCell.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayersViewCell.h"

@implementation PlayersViewCell

@synthesize mainLabel, leftImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        int cellWidth = self.contentView.frame.size.width;
        int cellHeight = self.contentView.frame.size.height;
        
        // Set Up Cell
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // Initialize Image and Label
        self.leftImageView = [[UIImageView alloc] init];
        [self.leftImageView setFrame:CGRectMake(5, 5, cellHeight-10, cellHeight-10)];
        self.mainLabel = [[UILabel alloc] init];
        [self.mainLabel setFrame:CGRectMake(leftImageView.frame.origin.x+leftImageView.frame.size.width+10, 5, cellWidth-20-leftImageView.frame.origin.x-leftImageView.frame.size.width, cellHeight-10)];
        
        // Add views to cell
        [self.contentView addSubview:self.leftImageView];
        [self.contentView addSubview:self.mainLabel];
        
        // Set Up Main Label
        [self.mainLabel setTextAlignment:UITextAlignmentLeft];
        [self.mainLabel setTextColor:[UIColor redColor]];
        //[self.mainLabel setShadowColor:[UIColor blackColor]];
        //[self.mainLabel setShadowOffset:CGSizeMake(1.0, 1.0)];
        [self.mainLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
