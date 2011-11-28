//
//  PlayerEditController.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerEditController.h"
#import "SCRAppDelegate.h"

@implementation PlayerEditController

@synthesize player, delegate, imagePicker, imageNew;

- (void)cancel {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
    
}

- (void)saveCustumCellwithCellID:(NSString *)cellID {
    if ([cellID isEqualToString:@"id_1_0"]) {
        [self.player setHanded:[handednessSegControl selectedSegmentIndex]];

    }
    if ([cellID isEqualToString:@"id_2_0"]) {
        if (self.imageNew) {
            self.player.image = self.imageNew;

        }
    }
}

- (void)saveNewPlayer {
    

    for (int i = 0; i < [sections count]; i++) {
        NSMutableArray *rows = [sections objectAtIndex:i];
        for (int j = 0; j < [rows count]; j++) {
            NSDictionary *dic = [rows objectAtIndex:j];
            NSString *cellID = [NSString stringWithFormat:@"id_%d_%d", i, j];
            if (![dic valueForKey:@"custom"]) {
                TextFieldCell *cell = [cellDictionary objectForKey:cellID];
                if ([[cell.cellInfo objectForKey:@"required"] boolValue]) {
                    if ([cell.textField.text isEqualToString:@""] || cell.textField.text == NULL) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You Must Enter a First and Last Name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
                        [alert show];
                        return;
                    }
                }

            }
        }
    }

    if (!self.player) {
        SCRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *moc = [appDelegate managedObjectContext];
        self.player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:moc];
    }
    
    
    for (int i = 0; i < [sections count]; i++) {
        NSMutableArray *rows = [sections objectAtIndex:i];
        for (int j = 0; j < [rows count]; j++) {
            NSDictionary *dic = [rows objectAtIndex:j];
            NSString *cellID = [NSString stringWithFormat:@"id_%d_%d", i, j];
            if ([dic valueForKey:@"custom"]) {
                [self saveCustumCellwithCellID:cellID];
            }

            else {
            TextFieldCell *cell = [cellDictionary objectForKey:cellID];
            [self.player setValue:cell.textField.text forKey:[cell.cellInfo objectForKey:@"property"]];
            }
            
        }
    }

    [self.delegate didChangeData];
    [self.parentViewController dismissModalViewControllerAnimated:YES];
    
}

- (void)setUpCustumCellwithCellID:(NSString *)cellID {
    
    
    if ([cellID isEqualToString:@"id_1_0"]) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Left-Handed", @"Right-Handed", nil]];
        segControl.frame = CGRectMake(0, 0, 300, cell.contentView.frame.size.height+5) ;
        [segControl setSegmentedControlStyle:UISegmentedControlStyleBar];
        [segControl setTintColor:[UIColor redColor]];
        
        handednessSegControl = segControl;
        if (self.player) {
            [segControl setSelectedSegmentIndex:[self.player getHanded]];
            
        }
        
        [cell.contentView addSubview:segControl];
        
        [cellDictionary setObject:cell forKey:cellID];

    }
    if ([cellID isEqualToString:@"id_2_0"]) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = @"Select New Picture";
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [cell.textLabel setTextColor:[UIColor redColor]];
        [cell.textLabel setTextAlignment:UITextAlignmentCenter];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cellDictionary setObject:cell forKey:cellID];
        
    }

}


- (void)initilizeCells {
    cellDictionary = [[NSMutableDictionary alloc] init];

    for (int i = 0; i < [sections count]; i++) {
        NSMutableArray *rows = [sections objectAtIndex:i];
        for (int j = 0; j < [rows count]; j++) {
            NSString *cellID = [NSString stringWithFormat:@"id_%d_%d", i, j];
            NSMutableDictionary *dic = [rows objectAtIndex:j];

            if ([dic valueForKey:@"custom"]) {
                [self setUpCustumCellwithCellID:cellID];
            }
            else {
            TextFieldCell *cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.cellInfo = dic;
            cell.identifierLabel.text = [dic objectForKey:@"labelID"];
            if ([[dic objectForKey:@"required"] boolValue]) {
                cell.textField.placeholder = @"Required";
            }
            NSString *currentText = (NSString *)[self.player valueForKey:[dic objectForKey:@"property"]];
            if (currentText) {
                cell.textField.text = currentText;
            }
            cell.textField.delegate = self;
            [cellDictionary setObject:cell forKey:cellID];
            }
        }
    }
}

- (void)retrievePropertyList {
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"Player-Edit" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:path];
    sections = [[NSMutableArray alloc] initWithArray:[root objectForKey:@"Root"]];
    
}

- (id)initWithStyle:(UITableViewStyle)style andPlayer:(Player *)editingPlayer {
    self = [super initWithStyle:style];
    if (self) {
        [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Wood_Background.png"]]];

        if (editingPlayer) {
            self.player = editingPlayer;
            self.title = @"Edit Player";
        }
        else self.title = @"Add New Player";
        [self retrievePropertyList];
        [self initilizeCells];
    }
    return self;

    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveNewPlayer)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
        
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[sections objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"id_%d_%d", indexPath.section, indexPath.row];

    
    UITableViewCell *cell = [cellDictionary objectForKey:cellID];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)custumSelectRowWithCellID:(NSString *)cellID {
    if ([cellID isEqualToString:@"id_2_0"]) {
            
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a New Picture", @"Choose from Gallery", nil];
        [actionSheet showInView:self.view];
        
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"id_%d_%d", indexPath.section, indexPath.row];
    NSMutableDictionary *dic = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if ([dic valueForKey:@"custom"]) {
        [self custumSelectRowWithCellID:cellID];
    }
    else {
        TextFieldCell *selectedCell = (TextFieldCell *)[cellDictionary objectForKey:cellID];
        [selectedCell.textField becomeFirstResponder];
    }
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Image Picker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    CGSize size = image.size;
	CGFloat ratio = 0;
	if (size.width > size.height) {
		ratio = 400.0 / size.width;
	}
	else {
		ratio = 400.0 / size.height;
	}
	CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
	
	UIGraphicsBeginImageContext(rect.size);
	[image drawInRect:rect];
	self.imageNew = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    [self.navigationController dismissModalViewControllerAnimated:YES];

}

#pragma mark - Action Sheet Delegate

- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            imgPicker.delegate = self;
            imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self.navigationController presentModalViewController:imgPicker animated:YES];
            break;
        }
        case 1: {
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            imgPicker.delegate = self;
            imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self.navigationController presentModalViewController:imgPicker animated:YES];
            break;
        }
                    
        default:
            break;
    }
}


@end
