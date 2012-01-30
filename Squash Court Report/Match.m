//
//  Match.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Match.h"
#import "Player.h"
#import "Game.h"


@implementation Match

@dynamic numberOfGames;
@dynamic p1GameScore;
@dynamic p2GameScore;
@dynamic datePlayed;
@dynamic player1;
@dynamic player2;
@dynamic games;
@dynamic city;
@dynamic complex;
@dynamic country;
@dynamic courtCondition;
@dynamic drawRound;
@dynamic matchType;
@dynamic notes;
@dynamic provinceState;
@dynamic recordingType;
@dynamic tournamentName;
@dynamic pointsPerGame;

-(NSSet *)rallies {
    NSSet *_rallies = [[NSSet alloc] init];
    for (Game *game in self.games) {
        _rallies = [_rallies setByAddingObjectsFromSet:game.rallies];
    }
    return _rallies;
    
}

-(int)p1WERatio {
    return 1;
}
-(int)p2WERatio {
    return 1;
}

-(int)p1RallyControlMargin {
    return 30;
}

-(int)p2RallyControlMargin {
    return 5;
}

-(NSArray *)getShotsWithFilter:(ShotFilter *)filter withPlayer1:(BOOL)player1 {
    NSSet *rallies = self.rallies;
    
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    if (filter.winners) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"finishingShot.intValue == %u", kWinner]];
    }
    if (filter.errors) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"finishingShot.intValue == %u", kError]];
    }
    if (filter.unforcedErrors) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"finishingShot.intValue == %u", kUnforcedError]];
    }
    if (filter.strokes) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"finishingShot.intValue == %u", kStroke]];
    }
    if (filter.lets) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"finishingShot.intValue == %u", kLet]];
    }
    if (filter.noLets) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"finishingShot.intValue == %u", kNoLet]];
    }
    
    //filter by court area
    NSPredicate *courtAreaPredicate = [NSPredicate predicateWithFormat:@"courtArea == %u", filter.courtArea];
            
    NSCompoundPredicate *compoundPredicate = [[NSCompoundPredicate alloc] initWithType:NSOrPredicateType subpredicates:predicates];
    
    NSPredicate *playerPredicate = player1 ? [NSPredicate predicateWithFormat:@"p1Finished == YES"] : [NSPredicate predicateWithFormat:@"p1Finished == NO"];
    
    
    NSPredicate *gamePredicate = [NSPredicate predicateWithFormat:@"game.number.intValue == %u", filter.gameNumber];
    
    NSCompoundPredicate *p1CompoundPredicate;
    
    if(filter.courtArea != CourtAreaFullCourt)
    {
        if(filter.gameNumber != 0)
            p1CompoundPredicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:[NSArray arrayWithObjects:compoundPredicate, playerPredicate, gamePredicate, courtAreaPredicate, nil]];
        else
            p1CompoundPredicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:[NSArray arrayWithObjects:compoundPredicate, playerPredicate, courtAreaPredicate, nil]];        
    }
    else
    {
        if(filter.gameNumber != 0)
            p1CompoundPredicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:[NSArray arrayWithObjects:compoundPredicate, playerPredicate, gamePredicate, nil]];
        else
            p1CompoundPredicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:[NSArray arrayWithObjects:compoundPredicate, playerPredicate, nil]];
    }
    
    
    return [[rallies filteredSetUsingPredicate:p1CompoundPredicate] sortedArrayUsingDescriptors:NULL];
}



-(Player *)winner {
    if (self.p1GameScore.intValue > self.p2GameScore.intValue) {
        return self.player1;
    }
    if (self.p2GameScore.intValue > self.p1GameScore.intValue) {
        return self.player2;
    }
    return NULL;
}

-(Player *)loser {
    if (self.p1GameScore.intValue > self.p2GameScore.intValue) {
        return self.player2;
    }
    if (self.p2GameScore.intValue > self.p1GameScore.intValue) {
        return self.player1;
    }
    return NULL;
}


@end
