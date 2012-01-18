//
//  Player.h
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum {
    kLeftHanded,
    kRightHanded
} handedness;

typedef enum {
    kFirstInitialLastName,
    kFirstInitialLastInitial,
    kFullName
} nameType;


@interface Player : NSManagedObject

@property (nonatomic, retain) NSDate * dateBorn;
@property (nonatomic, retain) NSNumber * handedness;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, readonly) NSSet * matches;
@property (nonatomic, retain) NSSet * matchesIAmPlayer1;
@property (nonatomic, retain) NSSet * matchesIAmPlayer2;
@property (nonatomic, retain) NSSet * rallies;

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * headCoach;
@property (nonatomic, retain) NSString * homeClub;
@property (nonatomic, retain) NSString * stateProvince;
@property (nonatomic, retain) NSString * style;
@property (nonatomic, retain) UIImage * image;
@property (readonly) int numberOfWins;
@property (readonly) int numberOfLosses;
@property (readonly) int numberOfMatches;
@property (readonly) int totalWinners;
@property (readonly) int totalErrors;
@property (readonly) int totalUnforcedErrors;
@property (readonly) int totalLets;
@property (readonly) int totalNoLets;
@property (readonly) int totalStrokes;
@property (readonly) float averageWinnersPerMatch;
@property (readonly) float averageErrorsPerMatch;
@property (readonly) float averageUnforcedErrorsPerMatch;
@property (readonly) float averageLetsPerMatch;
@property (readonly) float averageNoLetsPerMatch;
@property (readonly) float averageStrokesPerMatch;

@end

@interface Player (CoreDataGeneratedAccessors)

- (void)setHanded:(int)handedness;
- (int)getHanded;

- (NSString *)getName:(nameType) nameType;

-(int)getNumberOfWins;
-(int)getNumberOfLosses;
-(int)getNumberOfMatches;
-(int)getNumberofWinnersPerMatch;
-(int)getNumberofErrorsPerMatch;



- (void)addMatchesIAmPlayer1Object:(NSManagedObject *)value;
- (void)removeMatchesIAmPlayer1Object:(NSManagedObject *)value;
- (void)addMatchesIAmPlayer1s:(NSSet *)values;
- (void)removeMatchesIAmPlayer1:(NSSet *)values;

- (void)addMatchesIAmPlayer2Object:(NSManagedObject *)value;
- (void)removeMatchesIAmPlayer2Object:(NSManagedObject *)value;
- (void)addMatchesIAmPlayer2s:(NSSet *)values;
- (void)removeMatchesIAmPlayer2:(NSSet *)values;

- (void)addRalliesObject:(NSManagedObject *)value;
- (void)removeRalliesObject:(NSManagedObject *)value;
- (void)addRallies:(NSSet *)values;
- (void)removeRallies:(NSSet *)values;



@end
