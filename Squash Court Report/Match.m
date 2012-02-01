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

-(float)p1WERatio {
    float p1winners = 0;
    float p1errors = 0;
    NSSet *tempRallies = self.rallies;
    for (Rally *rally in tempRallies) {
        if (rally.finishingShot.intValue == kWinner && rally.p1Finished.boolValue == YES) {
            p1winners++;
        }
        else if ((rally.finishingShot.intValue == kUnforcedError || rally.finishingShot.intValue == kError) && rally.p1Finished.boolValue == YES) {
            p1errors++;
        }
    }
    return p1winners/p1errors;
}

-(float)p2WERatio {
    float p2winners = 0;
    float p2errors = 0;
    NSSet *tempRallies = self.rallies;
    for (Rally *rally in tempRallies) {
        if (rally.finishingShot.intValue == kWinner && rally.p1Finished.boolValue == NO) {
            p2winners++;
        }
        else if ((rally.finishingShot.intValue == kUnforcedError || rally.finishingShot.intValue == kError) && rally.p1Finished.boolValue == NO) {
            p2errors++;
        }
    }
    return p2winners/p2errors;
}

-(float)p1RallyControlMargin {
    float p1Winners = 0;
    float p1UnforcedErrors = 0;
    float p1TotalErrors = 0;
    float p2Winners = 0;
    float p2TotalErrors = 0;
    float p2Errors = 0;
    NSSet *tempRallies = self.rallies;
    for (Rally *rally in tempRallies) {
        switch (rally.finishingShot.intValue) {
            case kWinner:
                if (rally.p1Finished.boolValue) p1Winners++;
                else p2Winners++;
                break;
            case kError:
                if (rally.p1Finished.boolValue) p1TotalErrors++;
                else {
                    p2TotalErrors++;
                    p2Errors++;
                }
                break;
            case kUnforcedError:
                if (rally.p1Finished.boolValue) {
                    p1UnforcedErrors++;
                    p1TotalErrors++;
                }
                else p2TotalErrors++;
                break;
            default:
                break;
        }
        
    }
    return (p1Winners + p2Errors - p1UnforcedErrors)/(p1Winners + p1TotalErrors + p2Winners + p2TotalErrors);
}

-(float)p2RallyControlMargin {
    float p2Winners = 0;
    float p2TotalErrors = 0;
    float p2UnforcedErros = 0;

    float p1Winners = 0;
    float p1Errors = 0;
    float p1TotalErrors = 0;
    
    NSSet *tempRallies = self.rallies;
    for (Rally *rally in tempRallies) {
        switch (rally.finishingShot.intValue) {
            case kWinner:
                if (rally.p1Finished.boolValue) p1Winners++;
                else p2Winners++;
                break;
            case kError:
                if (rally.p1Finished.boolValue) {
                    p1TotalErrors++;
                    p1Errors++;
                }
                else {
                    p2TotalErrors++;
                }
                break;
            case kUnforcedError:
                if (rally.p1Finished.boolValue) {
                    p1TotalErrors++;
                }
                else {
                    p2TotalErrors++;
                    p2UnforcedErros++;
                }
                break;
            default:
                break;
        }
        
    }
    return (p2Winners + p1Errors - p2UnforcedErros)/(p2Winners + p2TotalErrors + p1Winners + p1TotalErrors);
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
    
    NSCompoundPredicate *compoundPredicate = [[NSCompoundPredicate alloc] initWithType:NSOrPredicateType subpredicates:predicates];
    
    NSPredicate *playerPredicate = player1 ? [NSPredicate predicateWithFormat:@"p1Finished == YES"] : [NSPredicate predicateWithFormat:@"p1Finished == NO"];
    
    NSCompoundPredicate *p1CompoundPredicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:[NSArray arrayWithObjects:compoundPredicate, playerPredicate, nil]];

    
    if (filter.gameNumber <= 5 && filter.gameNumber > 0) {
        NSPredicate *gamePredicate = [NSPredicate predicateWithFormat:@"game.number.intValue == %u", filter.gameNumber];
        p1CompoundPredicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:[NSArray arrayWithObjects:p1CompoundPredicate, gamePredicate, nil]];

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
