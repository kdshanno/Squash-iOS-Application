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

@interface Match : NSManagedObject

@property (nonatomic, retain) NSNumber * numberOfGames;
@property (nonatomic, retain) NSNumber * p1GameScore;
@property (nonatomic, retain) NSNumber * p2GameScore;
@property (nonatomic, retain) NSDate * datePlayed;
@property (nonatomic, retain) Player *player1;
@property (nonatomic, retain) Player *player2;
@property (nonatomic, retain) NSSet *games;
@end

@interface Match (CoreDataGeneratedAccessors)

- (void)addGamesObject:(NSManagedObject *)value;
- (void)removeGamesObject:(NSManagedObject *)value;
- (void)addGames:(NSSet *)values;
- (void)removeGames:(NSSet *)values;

@end
