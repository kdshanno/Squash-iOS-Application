//
//  Match.h
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player;

typedef enum {
    kPractice,
    kTournament
} matchType;

typedef enum {
    kFilm,
    kLive
} recordingType;

@interface Match : NSManagedObject

@property (nonatomic, retain) NSNumber * numberOfGames;
@property (nonatomic, retain) NSNumber * pointsPerGame;
@property (nonatomic, retain) NSNumber * p1GameScore;
@property (nonatomic, retain) NSNumber * p2GameScore;
@property (nonatomic, retain) NSDate * datePlayed;
@property (nonatomic, retain) Player * player1;
@property (nonatomic, retain) Player * player2;
@property (nonatomic, retain) NSSet *games;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * complex;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * courtCondition;
@property (nonatomic, retain) NSString * drawRound;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * provinceState;
@property (nonatomic, retain) NSString * tournamentName;
@property (nonatomic, retain) NSNumber * matchType;
@property (nonatomic, retain) NSNumber * recordingType;


@end

@interface Match (CoreDataGeneratedAccessors)

- (void)addGamesObject:(NSManagedObject *)value;
- (void)removeGamesObject:(NSManagedObject *)value;
- (void)addGames:(NSSet *)values;
- (void)removeGames:(NSSet *)values;

@end
