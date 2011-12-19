//
//  PlayerEditController.h
//  Squash Court Report
//
//  Created by Max Shaw on 10/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataModel.h"
#import "TextFieldCell.h"



@protocol PlayerEditDelegate <NSObject>

- (void)didChangeData;

@end

@interface PlayerEditController : UITableViewController <UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIActionSheetDelegate> {
    
    NSMutableDictionary *cellDictionary;
    UISegmentedControl *handednessSegControl;
    NSMutableArray *sections;
    UIImage *imageNew;
    UIImagePickerController *imagePicker;
}

@property (strong, nonatomic) Player *player;
@property (strong, nonatomic) UIImage *imageNew;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (retain) id delegate;

- (id)initWithStyle:(UITableViewStyle)style andPlayer:(Player *)editingPlayer;

@end
