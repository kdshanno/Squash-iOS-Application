//
//  MatchOverviewCustomCell.h
//  Squash Court Report
//
//  Created by Max Shaw on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareButton.h"

@protocol MatchOverviewCustomCellDelegate <NSObject>

-(void)leftButtonWasSelectedAtIndexPath:(NSIndexPath *)row;
-(void)centerButtonWasSelectedAtIndexPath:(NSIndexPath *)row;
-(void)rightButtonWasSelectedAtIndexPath:(NSIndexPath *)row;

@end

@interface MatchOverviewCustomCell : UITableViewCell {
    id delegate;
}

@property (nonatomic, strong) IBOutlet SquareButton *leftButton;
@property (nonatomic, strong) IBOutlet SquareButton *centerButton;
@property (nonatomic, strong) IBOutlet SquareButton *rightButton;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIColor *highlightColor;
@property (nonatomic, strong) id delegate;

- (IBAction)leftButtonPressed:(id)sender;
- (IBAction)centerButtonPressed:(id)sender;
- (IBAction)rightButtonPressed:(id)sender;



@end
