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


@interface Player : NSManagedObject {
    UIImage *imageCache;
}

@property (nonatomic, retain) NSDate * dateBorn;
@property (nonatomic, retain) NSNumber * handedness;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSSet * matches;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * headCoach;
@property (nonatomic, retain) NSString * homeClub;
@property (nonatomic, retain) NSString * stateProvince;
@property (nonatomic, retain) NSString * style;
@property (nonatomic, retain) NSData * imageData;

@end

@interface Player (CoreDataGeneratedAccessors)

- (void)setHanded:(int)handedness;
- (int)getHanded;

- (NSString *)getName:(nameType) nameType;
- (void)setImage:(UIImage *)image;
- (UIImage *)getImage;

-(int)getNumberOfWins;
-(int)getNumberOfLosses;
-(int)getNumberOfMatches;

- (void)addMatchesObject:(NSManagedObject *)value;
- (void)removeMatchesObject:(NSManagedObject *)value;
- (void)addMatches:(NSSet *)values;
- (void)removeMatches:(NSSet *)values;




@end
