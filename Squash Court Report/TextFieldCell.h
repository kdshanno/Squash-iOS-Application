//
//  PlayerProfileCell.h
//  Squash Court Report
//
//  Created by Max Shaw on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldCell : UITableViewCell

@property (strong, nonatomic) UILabel *identifierLabel;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSMutableDictionary *cellInfo;

@end
