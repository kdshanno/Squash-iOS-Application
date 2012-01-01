//
//  MatchListCell.m
//  Squash Court Report
//
//  Created by Rishi on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MatchListCell.h"

@implementation MatchListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;

        [self.textLabel setTextColor:[UIColor redColor]];
        [self.textLabel setFont:[UIFont fontWithName:self.detailTextLabel.font.fontName size:16]];
        [self.textLabel setAdjustsFontSizeToFitWidth:YES];
        [self.textLabel setMinimumFontSize:10];
        
        [self.detailTextLabel setTextColor:[UIColor blackColor]];
        [self.detailTextLabel setFont:[UIFont fontWithName:self.detailTextLabel.font.fontName size:12]];
        [self.detailTextLabel setAdjustsFontSizeToFitWidth:YES];
        [self.detailTextLabel setMinimumFontSize:10];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect oldFrame = [self.imageView frame];
    CGRect newFrame = CGRectMake(oldFrame.origin.x + 4, oldFrame.origin.y + 4, oldFrame.size.width - 8, oldFrame.size.height - 8);
    [self.imageView setFrame:newFrame];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.imageView setClipsToBounds:YES];
}

@end
