//
//  PlayerProfileCell.h
//  Squash Court Report
//
//  Created by Maxwell Shaw on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PLAYERCELLHEIGHT 34

@interface PlayerProfileCell : UITableViewCell

@property (strong, nonatomic) UILabel *leftLabel;
@property (strong, nonatomic) UILabel *rightLabel;
@property (nonatomic) BOOL showDisclosure;



@end
