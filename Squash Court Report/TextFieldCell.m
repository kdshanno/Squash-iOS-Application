//
//  PlayerProfileCell.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TextFieldCell.h"


@implementation TextFieldCell

@synthesize identifierLabel, textField;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        int cellWidth = self.contentView.frame.size.width;
        int cellHeight = self.contentView.frame.size.height;
        int labelWidth = 80;
        
        // Set Up Cell
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Initialize Text Field and Label
        self.identifierLabel = [[UILabel alloc] init];
        [self.identifierLabel setFrame:CGRectMake(5, 5, labelWidth, cellHeight-10)];
        [self.identifierLabel setTextAlignment:UITextAlignmentRight];
        [self.identifierLabel setTextColor:[UIColor redColor]];
        [self.identifierLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [self.identifierLabel setBackgroundColor:[UIColor clearColor]];
        
        self.textField = [[UITextField alloc] init];
        [self.textField setFrame:CGRectMake(labelWidth+15, 9, cellWidth-labelWidth-20, cellHeight-10)];
        [self.textField setMinimumFontSize:16];
        [self.textField setFont:[UIFont fontWithName:@"Helvetica" size:20]];
         
        // Add views to cell
        [self.contentView addSubview:self.identifierLabel];
        [self.contentView addSubview:self.textField];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
