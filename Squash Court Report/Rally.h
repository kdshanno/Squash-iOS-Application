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

typedef enum {
    CourtAreaFrontLeft = 0,
    CourtAreaFrontRight = 1,
    CourtAreaMiddleLeft = 2,
    CourtAreaMiddleRight = 3,
    CourtAreaBackLeft = 4,
    CourtAreaBackRight = 5,
    CourtAreaFullCourt = 6
} courtAreaType;

typedef enum {
    kWinner = 0,
    kUnforcedError = 1,
    kError = 2,
    kNoLet = 3,
    kLet = 4,
    kStroke = 5
} ender;

@interface Rally : NSManagedObject

@property (nonatomic, retain) NSNumber * finishingShot;
@property (nonatomic, retain) NSNumber * p1Finished;

@property (nonatomic, retain) NSNumber * p1Score;
@property (nonatomic, retain) NSNumber * p2Score;
@property (nonatomic, retain) NSNumber * pointNumber;
@property (nonatomic, retain) NSNumber * xPosition;
@property (nonatomic, retain) NSNumber * yPosition;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) NSManagedObject *game;
@property (readonly) courtAreaType courtArea;

-(int)getPreviousp1Score;
-(int)getPreviousp2Score;
- (courtAreaType)courtAreaType;
- (NSString *)courtAreaString;
+ (courtAreaType)typeForString:(NSString *)string;
+ (NSArray *)courtAreaTypes;


@end
