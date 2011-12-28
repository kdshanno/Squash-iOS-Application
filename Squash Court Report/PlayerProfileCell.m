//
//  PlayerProfileCell.m
//  Squash Court Report
//
//  Created by Maxwell Shaw on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerProfileCell.h"
#import "CustomDisclosureIndicator.h"

@implementation PlayerProfileCell


@synthesize leftLabel, rightLabel;
@synthesize showDisclosure = _showDisclosure;

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
//        [backgroundView setFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
//        [self.contentView addSubview:backgroundView];
        
        self.backgroundView =  backgroundView;
    
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, cellWidth, cellHeight)];
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

#define kDISCOLSURE_INDICATOR_TAG 333

- (void)setShowDisclosure:(BOOL)showDisclosure {
    _showDisclosure = showDisclosure;
    if (_showDisclosure && ![self.contentView viewWithTag:kDISCOLSURE_INDICATOR_TAG]) {
        CustomDisclosureIndicator *ind = [[CustomDisclosureIndicator alloc] initWithFrame:CGRectMake(285, 8, 11, 18)];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        ind.tag = kDISCOLSURE_INDICATOR_TAG;
        [self.contentView addSubview:ind];
    }
    else {
        if ([self.contentView viewWithTag:kDISCOLSURE_INDICATOR_TAG]) {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [[self.contentView viewWithTag:kDISCOLSURE_INDICATOR_TAG] removeFromSuperview];

        }
    }
         
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
