//
//  Rally.h
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player;

@interface Rally : NSManagedObject

@property (nonatomic, retain) NSNumber * finishingShot;
@property (nonatomic, retain) NSNumber * p1Score;
@property (nonatomic, retain) NSNumber * p2Score;
@property (nonatomic, retain) NSNumber * pointNumber;
@property (nonatomic, retain) NSNumber * xPosition;
@property (nonatomic, retain) NSNumber * yPosition;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) NSManagedObject *game;

@end
