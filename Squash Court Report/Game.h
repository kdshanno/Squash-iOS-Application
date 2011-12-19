//
//  Game.h
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Match, Rally;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSNumber * p1Score;
@property (nonatomic, retain) NSNumber * p2Score;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) Match *match;
@property (nonatomic, retain) NSSet *rallies;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)addRalliesObject:(Rally *)value;
- (void)removeRalliesObject:(Rally *)value;
- (void)addRallies:(NSSet *)values;
- (void)removeRallies:(NSSet *)values;

@end
